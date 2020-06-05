# Mockoutube
A basic Rails application

### Getting started

Clone the repository to your local machine:
```
$ git clone https://github.com/therealedsheenan/mockoutube.git
```

Install the necessary dependencies
```
$ cd mockoutube # If you're note in the current project directory yet
$ bundle install
$ yarn install
```

Setup database
```
$ bundle exec rails db:setup
```

Run the server
```
$ bundle exec rails s
```

### Tests
To run test, run the following command:
```
$ bundle exec rails test
```

#### Highlighted test scripts
The following directories are the main test scripts:

- `test/controllers/**`
- `test/controllers/models/**`
- `test/controllers/system/**`
