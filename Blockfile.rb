require 'pathname'

# Paths used in this Blockfile implementation
ROOT_PATH =  Pathname.new(__FILE__).parent.realpath
BLOCKS_PATH = ROOT_PATH + 'blocks'
BUILD_PATH = ROOT_PATH + 'app/assets/blocks'

###################################################################################

# Define the directory where WebBlocks will place the final build products.
set :build_path, BUILD_PATH

# Include the opt site block, from whence all else should be included.
include 'next', 'site'

# This proc, which should be executed as "instance_exec(path, &autoload_files_as_blocks)" from within a block def,
# will load all files directly within the directory path, using the file name as the block name, and the extension to
# determine which type of file to implicitly load the file into the block as.
autoload_files_as_blocks = Proc.new do |path|
  Dir.entries(path).keep_if(){ |fp| File.file?(path + fp) }.each do |fp|
    case /\.[^\.]*$/.match(fp).to_s
      when '.js'
        block(fp.gsub(/\.[^\.]*$/, ''), required: true){ js_file fp }
      when '.scss'
        block(fp.gsub(/\.[^\.]*$/, ''), required: true){ scss_file fp }
    end
  end
end

# Define the "opt" block for this application.
block 'next', :path => BLOCKS_PATH do |n|

  # Define the "config" block of variables and other non-runnable stuff.
  config = block 'config', :path => 'config' do |config|

    # For the config block, load all config files with their name as their block name
    instance_exec(BLOCKS_PATH + 'config', &autoload_files_as_blocks)

  end

  bootstrap = block 'bootstrap', path: 'bootstrap' do |bootstrap|

    dependency framework.route 'bootstrap', 'utilities'
    dependency framework.route 'bootstrap', 'responsive-utilities'
    dependency framework.route 'bootstrap', 'grid'
    dependency framework.route 'bootstrap', 'navbar'
    dependency framework.route 'bootstrap', 'buttons'
    dependency framework.route 'bootstrap', 'type'
    dependency framework.route 'bootstrap', 'panels'
    dependency framework.route 'bootstrap', 'tables'
    dependency framework.route 'bootstrap', 'alerts'
    dependency framework.route 'bootstrap', 'list-group'
    dependency framework.route 'bootstrap', 'glyphicons'
    dependency framework.route 'bootstrap', 'close'
    dependency framework.route 'bootstrap', 'progress-bars'
    dependency framework.route 'bootstrap', 'js', 'collapse'
    dependency framework.route 'bootstrap', 'js', 'dropdown'
    dependency framework.route 'bootstrap', 'js', 'modal'
    dependency framework.route 'bootstrap', 'js', 'tab'
    dependency framework.route 'bootstrap', 'js', 'tooltip'
    dependency framework.route 'bootstrap', 'js', 'alert'

    # For the components block, load all component files with their name as their block name.
    instance_exec(BLOCKS_PATH + 'bootstrap', &autoload_files_as_blocks)

    # Make each block dependent on the equivalent block in Bootstrap
    bootstrap.children.keys.each { |name| block(name) { dependency framework.route 'bootstrap', name } }

  end

  # Define the "components" sub-block of general-purpose elements.
  components = block 'components', path: 'component' do |components|

    # Components all depend on Normalize.css
    dependency framework.route 'normalize.css'
    dependency framework.route 'WebBlocks-visibility', 'hide'
    dependency framework.route 'WebBlocks-visibility', 'accessible'
    dependency framework.route 'WebBlocks-visibility', 'breakpoint'
    dependency bootstrap.route

    # For the components block, load all component files with their name as their block name.
    instance_exec(BLOCKS_PATH + 'component', &autoload_files_as_blocks)

  end

  # Define the "site" sub-block of site-specific elements.
  site = block 'site', :path => 'site' do |site|

    # Define dependencies that should be loaded before the site block.
    dependency framework.route 'jquery'
    dependency config.route
    dependency components.route

    # For the site block, load all site definition files with their name as their block name.
    instance_exec(BLOCKS_PATH + 'site', &autoload_files_as_blocks)

  end

end
