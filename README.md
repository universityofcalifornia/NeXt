# NeXt Platform

## Status

[![Dependency Status](https://gemnasium.com/universityofcalifornia/NeXt.png)](https://gemnasium.com/universityofcalifornia/NeXt) [![Code Climate](https://codeclimate.com/github/universityofcalifornia/NeXt.png)](https://codeclimate.com/github/universityofcalifornia/NeXt) [![Build Status](https://travis-ci.org/universityofcalifornia/NeXt.png?branch=master)](https://travis-ci.org/universityofcalifornia/NeXt) [![Coverage Status](https://coveralls.io/repos/universityofcalifornia/NeXt/badge.png?branch=master)](https://coveralls.io/r/universityofcalifornia/NeXt?branch=master)

This repository contains the code base for UC NeXt platform, which is currently **under development** and **not intended for use at this time**.

## License

The UC NeXt platform is open-source software licensed under the **BSD 3-clause license**. The full text of the license may be found in the [LICENSE](https://github.com/universityofcalifornia/NeXt/blob/master/LICENSE.txt) file.

## Credits

The development of the UC NeXt platform is managed by [Eric Bollens](https://github.com/ebollens) as part of the UC NeXt initiative. The UC NeXt platform is a product of its collaborators, including those who have contributed code, submitted bugs or even simply participated in the dialogue.

The UC NeXt platform is built on top of a number of outstanding open source platforms and packages including [Ruby](http://www.ruby-lang.org/), [RubyGems](http://rubygems.org/), [Bundler](http://gembundler.com/), [Ruby on Rails](http://rubyonrails.org/), [Rake](http://rake.rubyforge.org/), [Node.js](http://nodejs.org/), [npm](https://npmjs.org/), [Saas](http://sass-lang.com/), [Compass](http://compass-style.org/), [WebBlocks](http://rubygems.org/gems/web_blocks), [Elasticsearch](http://elasticsearch.org), [Bootstrap](http://getbootstrap.com), [Normalize.css](http://necolas.github.io/normalize.css/) and [jQuery](http://jquery.org). Its quality is assured by [Gemnasium](https://gemnasium.com/), [Code Climate](https://codeclimate.com/), [Travis CI](https://travis-ci.org) and [Coveralls](https://coveralls.io/). A sincere thanks is extended to the authors, maintainers and providers of all these fine tools.

## Setup

### Prerequisites

* [Ruby](https://www.ruby-lang.org) 2.1+
* [Bundler](http://bundler.io/)
* [Node.js](http://nodejs.org/)
* [npm](https://www.npmjs.org/)
* [Git](http://git-scm.com/)
* Java 7.x JDK ([Oracle](http://www.oracle.com/technetwork/java/javase) / [OpenJDK](http://openjdk.java.net/install/))
* [Elasticsearch 1.x](http://www.elasticsearch.org/)

### Build

Install required Ruby packages:

```
bundle install
```

Install required Node.js packages:

```
npm install
```

Build your CSS and JS assets with WebBlocks:

```
bundle exec blocks build
```

When editing CSS and JS assets, rerun the above command to recompile your site CSS and JS.

### Configure

Set your database connection details in `config/database.yml`.

### Authorization

Two authorization methods are supported:

* Local users, recommended for development use
* Shibboleth via OAuth, recommended for production use

#### Local Users

By default, the development environment is set up to use local login.

The configuration for this is available in `config/environments/[your rails environment name].yml`:

```yaml
auth:
  route: /auth/local/new
  allow_local: true
```

If local login is supported, once you seed the database (see the "Usage" section), you'll be able to log in with the starting account **admin@localhost** and the password **password**.

#### Shibboleth via OAuth

The easiest way to integrate this application with Shibboleth is to bridge it across OAuth. See:

> https://github.com/ebollens/shib-oauth2-bridge

Once this is set up, define the route to the bridge within `config/environments/[your rails environment name].yml`:

```yaml
oauth2:
  provider:
    shibboleth:
      enabled: true
      key: your-key
      secret: your-secret
      properties:
        site: http://shib.auth.localhost
        authorize_url: /oauth2/authorize
        token_url: /oauth2/access_token
      routes:
        get_user: /oauth2/user
```

The login route via Shibboleth is then available at /auth/oauth2/shibboleth.

You should also change the `auth` block in `config/environments/[your rails environment name].yml`:

```yaml
auth:
  route: /auth/oauth2/shibboleth
  allow_local: false
```

## Usage

Run the following commands to populate the database:

```
bundle exec rake db:migrate RAILS_ENV=development
bundle exec rake db:seed RAILS_ENV=development
```

If using SQLite, you can erase your development database as (and then must rerun the above migration & seed):

```
rm -rf db/development.sqlite3
```

Run the application as:

```
RAILS_ENV=development bundle exec thin start --ssl -p 8080
```