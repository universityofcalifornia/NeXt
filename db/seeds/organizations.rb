logger.progname = 'Seed - Organizations'

logger.info 'Truncate'
Organization.truncate

[
  { name: 'Berkeley', shortname: 'UCB', url: 'http://berkeley.edu/' },
  { name: 'Davis', shortname: 'UCD', url: 'http://ucdavis.edu/' },
  { name: 'Irvine', shortname: 'UCI', url: 'http://uci.edu/' },
  { name: 'Los Angeles', shortname: 'UCLA', url: 'http://ucla.edu' },
  { name: 'Merced', shortname: 'UCM', url: 'http://www.ucmerced.edu/' },
  { name: 'Riverside', shortname: 'UCR', url: 'http://www.ucr.edu/' },
  { name: 'San Diego', shortname: 'UCSD', url: 'http://ucsd.edu' },
  { name: 'San Francisco', shortname: 'UCSF', url: 'http://ucsf.edu' },
  { name: 'Santa Barbara', shortname: 'UCSB', url: 'http://ucsb.edu' },
  { name: 'Santa Cruz', shortname: 'UCSC', url: 'http://ucsc.edu' },
  { name: 'Office of the President', shortname: 'UCOP', url: 'http://www.ucop.edu/' },
  { name: 'Lawrence Berkeley Lab', shortname: 'LBL', url: 'http://www.lbl.gov/' },
  { name: 'Lawrence Livermore National Lab', shortname: 'LLNL', url: 'https://www.llnl.gov' },
  { name: 'Los Alamos National Laboratory', shortname: 'LANL', url: 'http://www.lanl.gov/' },
  { name: 'Agriculture &amp; National Resources', shortname: 'ANR', url: 'http://ucanr.edu/' },
  { name: 'Hastings', shortname: 'UC Hastings', url: 'http://www.uchastings.edu/' },
  { name: 'California Digital Library', shortname: 'CDL', url: 'http://www.cdlib.org/' }
].each do |data|
  logger.info "Create - #{data[:shortname]} => #{data[:name]}"
  Organization.create(data)
end



