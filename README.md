# Bulwark [![Code Climate](https://codeclimate.com/repos/571a2d7e5bd56f13060002a9/badges/b5171ef5b97a22f27c48/gpa.svg)](https://codeclimate.com/repos/571a2d7e5bd56f13060002a9/feed)

Mass update your S3 file permissions.

## Requirements
* Ruby 2.0 or greater

## Installation
Install from Rubygems:

```ruby
gem install bulwark
```

Or add it to your Gemfile:

```ruby
gem 'bulwark'
```

## Usage
Create a `.env` file. Populate it with your S3 Bucket credentials:
```ruby
S3_ACCESS_KEY_ID=foobar
S3_BUCKET=foobar
S3_REGION=foobar
S3_SECRET_ACCESS_KEY=foobar
```
***If your S3 region is US Standard, set S3_REGION=us-east-1***


Make all your S3 files private:
```sh
$ bulwark s3_files:privatize
```

Or make all your S3 files public-read:
```sh
$ bulwark s3_files:publicize
```
