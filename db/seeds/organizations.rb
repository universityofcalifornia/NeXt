logger.progname = 'Seed - Organizations'

[
  { name: 'Berkeley', shortname: 'UCB', url: 'http://berkeley.edu/', engagement_meter_display: true, domain: 'berkeley.edu' },
  { name: 'Davis', shortname: 'UCD', url: 'http://ucdavis.edu/', engagement_meter_display: true, domain: 'ucdavis.edu' },
  { name: 'Irvine', shortname: 'UCI', url: 'http://uci.edu/', engagement_meter_display: true, domain: 'uci.edu' },
  { name: 'Los Angeles', shortname: 'UCLA', url: 'http://ucla.edu', engagement_meter_display: true, domain: 'ucla.edu' },
  { name: 'Merced', shortname: 'UCM', url: 'http://www.ucmerced.edu/', engagement_meter_display: true, domain: 'ucmerced.edu' },
  { name: 'Riverside', shortname: 'UCR', url: 'http://www.ucr.edu/', engagement_meter_display: true, domain: 'ucr.edu' },
  { name: 'San Diego', shortname: 'UCSD', url: 'http://ucsd.edu', engagement_meter_display: true, domain: 'ucsd.edu' },
  { name: 'San Francisco', shortname: 'UCSF', url: 'http://ucsf.edu', engagement_meter_display: true, domain: 'ucsf.edu' },
  { name: 'Santa Barbara', shortname: 'UCSB', url: 'http://ucsb.edu', engagement_meter_display: true, domain: 'ucsb.edu' },
  { name: 'Santa Cruz', shortname: 'UCSC', url: 'http://ucsc.edu', engagement_meter_display: true, domain: 'ucsc.edu' },
  { name: 'Office of the President', shortname: 'UCOP', url: 'http://www.ucop.edu/', engagement_meter_display: true, domain: 'ucop.edu' },
  { name: 'Lawrence Berkeley Lab', shortname: 'LBL', url: 'http://www.lbl.gov/', engagement_meter_display: true, domain: 'lbl.gov' },
  { name: 'Lawrence Livermore National Lab', shortname: 'LLNL', url: 'https://www.llnl.gov', engagement_meter_display: true, domain: 'llnl.gov' },
  { name: 'Los Alamos National Laboratory', shortname: 'LANL', url: 'http://www.lanl.gov/', engagement_meter_display: true, domain: 'lanl.gov' },
  { name: 'Agriculture & National Resources', shortname: 'ANR', url: 'http://ucanr.edu/', engagement_meter_display: true, domain: 'ucanr.edu' },
  { name: 'Hastings', shortname: 'UC Hastings', url: 'http://www.uchastings.edu/', engagement_meter_display: true, domain: 'uchastings.edu' },
  { name: 'California Digital Library', shortname: 'CDL', url: 'http://www.cdlib.org/', engagement_meter_display: true, domain: 'cdlib.org' }
].each do |data|
  logger.info "Create - #{data[:shortname]} => #{data[:name]}"
  Organization.create(data)
end
