# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(name_first: 'Example',
            name_last: 'User',
            email: 'example@mail.localhost',
            super_admin: true,
            oauth2_identities: [
              Oauth2Identity.new(provider: 'shibboleth',
                                    provider_user_id: 'example@localhost')
            ])

