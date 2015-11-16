logger.progname = 'Seed - Organizations'

logger.info 'Truncate'
Organization.truncate

[
  { name: 'Berkeley', shortname: 'UCB', url: 'http://berkeley.edu/', engagement_meter_display: true },
  { name: 'Davis', shortname: 'UCD', url: 'http://ucdavis.edu/', engagement_meter_display: true },
  { name: 'Irvine', shortname: 'UCI', url: 'http://uci.edu/', engagement_meter_display: true },
  { name: 'Los Angeles', shortname: 'UCLA', url: 'http://ucla.edu', engagement_meter_display: true },
  { name: 'Merced', shortname: 'UCM', url: 'http://www.ucmerced.edu/', engagement_meter_display: true },
  { name: 'Riverside', shortname: 'UCR', url: 'http://www.ucr.edu/', engagement_meter_display: true },
  { name: 'San Diego', shortname: 'UCSD', url: 'http://ucsd.edu', engagement_meter_display: true },
  { name: 'San Francisco', shortname: 'UCSF', url: 'http://ucsf.edu', engagement_meter_display: true },
  { name: 'Santa Barbara', shortname: 'UCSB', url: 'http://ucsb.edu', engagement_meter_display: true },
  { name: 'Santa Cruz', shortname: 'UCSC', url: 'http://ucsc.edu', engagement_meter_display: true },
  { name: 'Office of the President', shortname: 'UCOP', url: 'http://www.ucop.edu/', engagement_meter_display: true },
  { name: 'Lawrence Berkeley Lab', shortname: 'LBL', url: 'http://www.lbl.gov/', engagement_meter_display: true },
  { name: 'Lawrence Livermore National Lab', shortname: 'LLNL', url: 'https://www.llnl.gov', engagement_meter_display: true },
  { name: 'Los Alamos National Laboratory', shortname: 'LANL', url: 'http://www.lanl.gov/', engagement_meter_display: true },
  { name: 'Agriculture & National Resources', shortname: 'ANR', url: 'http://ucanr.edu/', engagement_meter_display: true },
  { name: 'Hastings', shortname: 'UC Hastings', url: 'http://www.uchastings.edu/', engagement_meter_display: true },
  { name: 'California Digital Library', shortname: 'CDL', url: 'http://www.cdlib.org/', engagement_meter_display: true }
].each do |data|
  logger.info "Create - #{data[:shortname]} => #{data[:name]}"
  Organization.create(data)
end
