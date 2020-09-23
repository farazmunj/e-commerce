DEVELOPER CODING TEST
=======================

Assignment
----------

* Create a production ready database structure and provide PHP code that defines the prices of products in an e-commerce store.
* For some of the products the store is using pricing rules like the ones described below in addition to regular ones:
  * 3 for 10 NOK
  * 19.99 NOK/kg
  * Buy two, get one free
* The code and data structure should allow for the flexible organisation of product and groups of products based on “pricing rules” or volume discounting

Deliverables
-----------
* Database migrations and sample data
* Code


Structure
----------
use vagrant and virtual box to create environment.
local server will run on http://192.168.33.10/

Database schema and sample data is in *data* folder

sample endpoing is on http://192.168.33.10/product/1

sample endpoing is on http://192.168.33.10/basket/add/1

continue unit testing 

 while(true) do clear; php vendor/bin/phpunit; sleep 8; done;
