#!/usr/bin/env ruby

require 'json'

CACHE_DIR = File.expand_path('~/.aws/cli/cache')

# Session exporter for aws-cli sessions (for easy copy/paste into shell
class AwsSessionExport
  attr_reader :sessions

  def initialize
    @sessions = Dir.glob("#{CACHE_DIR}/*.json")
    fail 'ERROR: No sessions found' if @sessions.length < 1
    @session_id = 0 # default if there is only one session
  end

  def choose_session
    puts 'Choose a session:'
    @sessions.each do |session|
      puts "#{@sessions.index(session)} #{File.basename(session)}"
    end
    @session_id = gets.to_i
    fail "Invalid index #{@session_id}" if @session_id > @sessions.length
  end

  def output_env
    session_data = JSON.parse(IO.read(@sessions[@session_id]))
    aws_access_key_id = session_data['Credentials']['AccessKeyId']
    aws_secret_access_key = session_data['Credentials']['SecretAccessKey']
    aws_session_token = session_data['Credentials']['SessionToken']
    puts <<-EOT.gsub(/^ {6}/, '')
      export AWS_ACCESS_KEY_ID='#{aws_access_key_id}'
      export AWS_SECRET_ACCESS_KEY='#{aws_secret_access_key}'
      export AWS_SESSION_TOKEN='#{aws_session_token}'
    EOT
  end
end

session = AwsSessionExport.new
session.choose_session if session.sessions.length > 1
session.output_env
