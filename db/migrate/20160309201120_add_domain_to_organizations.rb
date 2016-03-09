class AddDomainToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :domain, :string

    domain_mappings = {
      "UCB"         => "berkeley.edu",
      "UCD"         => "ucdavis.edu",
      "UCI"         => "uci.edu",
      "UCLA"        => "ucla.edu",
      "UCM"         => "ucmerced.edu",
      "UCR"         => "ucr.edu",
      "UCSD"        => "ucsd.edu",
      "UCSF"        => "ucsf.edu",
      "UCSB"        => "ucsb.edu",
      "UCSC"        => "ucsc.edu",
      "UCOP"        => "ucop.edu",
      "LBL"         => "lbl.gov",
      "LLNL"        => "llnl.gov",
      "LANL"        => "lanl.gov",
      "ANR"         => "ucanr.edu",
      "UC Hastings" => "uchastings.edu",
      "CDL"         => "cdlib.org"
    }

    # Create domains for existing organizations
    domain_mappings.each do |k, v|
      org = Organization.find_by_shortname k
      next unless org
      org.domain = v
      org.save
    end
  end
end
