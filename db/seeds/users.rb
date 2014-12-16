logger.progname = 'Seed - Users'

logger.info 'Truncate'
User.truncate

logger.info 'Create - oauth2_identity[shibboleth, example@localhost]'
User.create(name_first: 'Example',
            name_last: 'User',
            email: 'example@mail.localhost',
            super_admin: true,
            oauth2_identities: [
                Oauth2Identity.new(provider: 'shibboleth',
                                   provider_user_id: 'example@localhost')
            ])

logger.info 'Create - oauth2_identity[shibboleth, ebollens@ucla.edu]'
User.create(name_first: 'Eric',
            name_middle: 'Ross',
            name_last: 'Bollens',
            email: 'ebollens@oit.ucla.edu',
            website: 'http://eb.io',
            phone_number: '310-206-1670',
            fax_number: '310-206-7025',
            mailing_address: 'Eric Bollens
UCLA Ofc of Infor Technol (OIT)
BOX 951557, 5308 MS
Los Angeles, CA 90095-1557',
            social_google: 'ebollens@g.ucla.edu',
            social_github: 'ebollens',
            social_linkedin: 'ebollens',
            social_twitter: 'ericbollens',
            super_admin: true,
            oauth2_identities: [
                Oauth2Identity.new(provider: 'shibboleth',
                                   provider_user_id: 'ebollens@ucla.edu')
            ],
            positions: [
                Position.new(organization: Organization.where(shortname: 'UCLA').first,
                             title: 'Open Source Architect',
                             department: 'Office of Information Technology')
            ])
