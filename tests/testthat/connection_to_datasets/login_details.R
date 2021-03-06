#  PRW - 22/02/2020 - This version uses some R6Classes. It is hoped to overcome some issues with not 
#  having access to ds.test_env

#This script determine all the login information to the servers used for the testing. 
#The first time, you will need to edit the server_ip_address. The latter is required to set 
#access to the data on the virtual machines. 
#=========================================================================================================
library(R6)
source("connection_to_datasets/init_local_settings.R")

set_config(config( ssl_verifypeer = 0L))
set_config(config( ssl_verifyhost = 0L))
init.ip.address()


LoginDetails <- R6Class("LoginDetails",
                        public = list(
                          driver = "OpalDriver",
                          contexts = c('opal','dsi','dslite','continuous','coverage'),
                          context = 'dsi',
                          server_ip_address = '',
                          ip_address_1 = '',
                          ip_address_2 = '',
                          ip_address_3 = '',
                          ping_address = '',
                          user_1 = "administrator",
                          user_2 = "administrator",
                          user_3 = "administrator",
                          password_1 = "datashield_test&",
                          password_2 = "datashield_test&",
                          password_3 = "datashield_test&",
                          ssl_options_1 = "list(ssl_verifyhost=0,ssl_verifypeer=0)",
                          ssl_options_2 = "list(ssl_verifyhost=0,ssl_verifypeer=0)",
                          ssl_options_3 = "list(ssl_verifyhost=0,ssl_verifypeer=0)",
                          secure_login_details = TRUE,
                          initialize = function(an_ip_address = "NULL")
                          {
                            self$server_ip_address <- an_ip_address
                            self$ip_address_1 <- paste("https://", self$server_ip_address, ":8443", sep="")
                            self$ip_address_2 <- paste("https://", self$server_ip_address, ":8443", sep="")
                            self$ip_address_3 <- paste("https://", self$server_ip_address, ":8443", sep="")
                            self$ping_address <- paste("http://" , self$server_ip_address, ":8080", sep="")
                          },
                          get_ip_addresses = function(no_servers)
                          {
                            ip_addresses <- c(self$ip_address_1,self$ip_address_2,self$ip_address_3)
                            if (no_servers > length(ip_addresses))
                            {
                              max_index = length(ip_addresses)
                            }
                            else 
                            {
                              max_index = no_servers
                            }
                            indices <- c(1:no_servers)
                            return(ip_addresses[indices])
                          },
                          get_users = function(no_servers)
                          {
                            users <- c(self$user_1, self$user_2, self$user_3)
                            if (no_servers > length(users))
                            {
                              max_index = length(users)
                            }
                            else 
                            {
                              max_index = no_servers
                            }
                            indices <- c(1:no_servers)
                            return(users[indices])
                          },
                          get_passwords = function(no_servers)
                          {
                            passwords <- c(self$password_1,self$password_2,self$password_3)
                            if (no_servers > length(passwords))
                            {
                              max_index = length(passwords)
                            }
                            else 
                            {
                              max_index = no_servers
                            }
                            indices <- c(1:no_servers)
                            return(passwords[indices])
                          },
                          get_drivers = function(no_servers)
                          {
                            return(c(rep(self$driver,no_servers)))
                          },
                          get_ssl_options = function(no_servers)
                          {
                            ssl_options <- c(self$ssl_options_1, self$ssl_options_2, self$ssl_options_3)
                            if (no_servers > length(ssl_options))
                            {
                              max_index = length(ssl_options)
                            }
                            else 
                            {
                              max_index = no_servers
                            }
                            indices <- c(1:no_servers)
                            return(ssl_options[indices])
                          }
                        )
)

login.details <- LoginDetails$new(init.ip.address())









