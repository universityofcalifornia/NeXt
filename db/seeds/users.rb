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