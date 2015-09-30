##
# Configuration settings
#
# @author: Daniele Gazzelloni <daniele@danielegazzelloni.com>
######################################################################


# General settings
exports.appName                   = "barbershop-challenge"
exports.serverPort                = 8881
exports.serverUrl                 = "http://localhost:#{this.serverPort}"
exports.customersAPI              = "/customers"

# MongoDB settings
exports.dbName                     = "barbershop-challenge"
exports.dbHostname                 = "mongodb://localhost/#{this.dbName}"
