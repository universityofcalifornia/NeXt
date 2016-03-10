logger.progname = 'Seed - Users'

logger.info 'Create - user[local, admin@localhost, password]'
ebollens = User.create(email: 'admin@localhost',
            name_first: 'Admin',
            name_last: 'User',
            super_admin: true,
            password_hash: BCrypt::Password.create('password'))

logger.info 'Create - oauth2_identity[shibboleth, ebollens@ucla.edu]'

bio_text = <<TXT
<p>A passionate web technologist, Eric Bollens works as a software architect for the Education and Collaboration Technology
Group in the UCLA Office of Information Technology. Tasked with developing and synthesizing new technologies and
solutions for UCLA's diverse academic and research environment, Eric has been involved with numerous campus-wide
 initiatives, most recently including the WebBlocks Responsive Web Toolkit, the Mobile Web Framework (MWF), the Online
Polling Tool (OPT) and a peer-to-peer app-sharing environment, as well as a number of other projects such as the UCLA
Common Collaboration and Learning Environment (CCLE Moodle) and UCLA on iTunes U.</p>

<p>Technical lead and framework architect for the WebBlocks Responsive Web Toolkit and the Mobile Web Framework, Eric
oversees technology development for both initiatives, coordinating their distributed developer communities and
maintaining their roadmaps, development processes and release cycles. His role, like the initiatives themselves, grew
out of UCLA Mobile (http://m.ucla.edu), a campus-specific offering he initially developed within the UCLA Office of
Information Technology to reduce the cost of mobilizing web resources at UCLA.</p>

<p>Beyond his work on WebBlocks, MWF and OPT, Eric has also retained a long-term role in both development and system
operations of the Common Collaboration and Learning Environment, the campus-wide LMS deployment of Moodle. He has
developed a number of security and performance modifications to CCLE, including several contributed back to the Moodle
open-source community, as well as helped maintain over 99.9% uptime for the campus-wide system over a four-year period.
Meanwhile, as the campus looked to expand its iTunes U offerings to include private course material, he led development
of an application that integrated Apple's Deimos web services, the campus identity management system, and various other
data sources.</p>

<p>Eric has also developed several other campus applications, as well as worked alongside the UCLA IT Security Office on
security audits and penetration testing, pinpointing vulnerabilities in UCLA's authentication system, wireless
infrastructure, payment gateway and others. He sits on the UC-wide Mobile Collaboration Group, the UCLA Mobile Steering
Committee, and has participated in working groups related to web security, content management systems, distributed
hosting, and student enrollment.</p>

<p>In recognition for his accomplishments, Eric is a two-time Gold winner of the UC-wide
<a href="http://www.ucop.edu/irc/itlc/sautter" target="_blank">Larry L. Sautter Award for Innovation in Information
Technology</a>, recognized for the Mobile Web Framework in 2011 and iTunes U in 2009.</p>
TXT

User.create(name_first: 'Eric',
            name_middle: 'Ross',
            name_last: 'Bollens',
            email: 'ebollens@ucla.edu',
            website: 'http://eb.io',
            phone_number: '310-206-1670',
            fax_number: '310-206-7025',
            mailing_address: 'Eric Bollens
UCLA Ofc of Infor Technol (OIT)
BOX 951557, 5308 MS
Los Angeles, CA 90095-1557',
            biography: bio_text,
            social_google: 'EricBollens',
            social_github: 'ebollens',
            social_linkedin: 'ebollens',
            social_twitter: 'ericbollens',
            super_admin: true,
            oauth2_identities: [
                Oauth2Identity.new(provider: 'shibboleth',
                                   provider_user_id: 'ebollens@ucla.edu')
            ],
            position: Position.new(organization: Organization.where(shortname: 'UCLA').first,
                                   title: 'Open Source Architect',
                                   department: 'Office of Information Technology')
            )

logger.info 'Create - oauth2_identity[shibboleth, example@localhost]'
User.create(name_first: 'Example',
            name_last: 'User',
            email: 'example@mail.localhost',
            super_admin: true,
            oauth2_identities: [
                Oauth2Identity.new(provider: 'shibboleth',
                                   provider_user_id: 'example@localhost')
            ])

logger.info 'Create - oauth2_identity[shibboleth, example2@localhost]'
User.create(name_first: 'John',
            name_last: 'Doe',
            email: 'example2@mail.localhost',
            oauth2_identities: [
                Oauth2Identity.new(provider: 'shibboleth',
                                   provider_user_id: 'example2@localhost')
            ])

logger.info 'Create - oauth2_identity[shibboleth, example3@localhost]'
User.create(name_first: 'Joe',
            name_last: 'Bruin',
            email: 'example3@mail.localhost',
            oauth2_identities: [
                Oauth2Identity.new(provider: 'shibboleth',
                                   provider_user_id: 'example3@localhost')
            ],
            position: Position.new(organization: Organization.where(shortname: 'UCLA').first,
                                   title: 'Fake Position',
                                   department: 'Non-Existent Department')
            )
