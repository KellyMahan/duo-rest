duo-rest
===========

This is a gem that provides access to the Duo Security Rest Api.

Methods
-------

1.  **ping**

    tests the connection to duo security rest api

2.  **check**

    checks your credentials for the correct keys
    
3.  **preauth**(username)

    information to display to the user to decide which way they want to log in.

4.  **auth**(username, auth_method)

    logging the user in.
    
    *the only tested auth method right now is push*
    
More Info
---------

For more info about the duo security process go [here](http://www.duosecurity.com/docs/duorest#process)