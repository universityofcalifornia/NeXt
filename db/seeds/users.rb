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

