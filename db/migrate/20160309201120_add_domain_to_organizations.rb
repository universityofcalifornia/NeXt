class AddDomainToOrganizations < ActiveRecord::Migration
  def up
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

    # Add organizations for any users that don't have them, based on their email address
    User.all.each do |user|
      next if user.organization

      if user.email.match /([a-z]+\.[a-z]+)$/
        org = Organization.find_by_domain $1
        if org
          user.organization = org
          user.save
        end
      end
    end
  end

  def down
    remove_column :organizations, :domain
  end
end
