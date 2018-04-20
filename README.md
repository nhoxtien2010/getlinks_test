# Introduce


This is a simple app describe manage product

## Set up environment

* Make sure you have to pre-install postgresql, ruby version 2.3.4
* Clone source from git repository: https://github.com/nhoxtien2010/getlinks_test.git
* Config database.yml depend on your local environment
* Run commands: 
    * `bundle install`
    * `rake db:create`
    * `rake db:migrate`
    * `rake db:seed` # to create the admin user with email: 'admin@example.com' and password: 'password'
* Run `rails s` to start server

## The web UI

![Alt text](./Screen\Shot\2018-04-20\at\9.45.03\PM.png?raw=true "Title")

![alt text](https://photos.google.com/u/2/share/AF1QipO6DfBK0ckVMXZ9WWik7qQs_ePKQn8lFelD-hc9LtlcGl-Q4IzkaxTdblrJsfQeaA/photo/AF1QipMnCQNw3yYAGAjc3iOZd1vxBLxrViowv6p4Kyi0?key=YTVOZTBfRnJOYlVITFp0QzJnYlVLdGg5SnN3RnJn)
![alt text](https://photos.google.com/u/2/share/AF1QipO6DfBK0ckVMXZ9WWik7qQs_ePKQn8lFelD-hc9LtlcGl-Q4IzkaxTdblrJsfQeaA/photo/AF1QipOUkVi0RU99v6Cy7sKui27PZQyOYUntL0zVPyB3?key=YTVOZTBfRnJOYlVITFp0QzJnYlVLdGg5SnN3RnJn)
![alt text](https://photos.google.com/u/2/share/AF1QipO6DfBK0ckVMXZ9WWik7qQs_ePKQn8lFelD-hc9LtlcGl-Q4IzkaxTdblrJsfQeaA/photo/AF1QipPn5s16XHyFLzFfG3RNIqN1b-1sbSgALMj0-53q?key=YTVOZTBfRnJOYlVITFp0QzJnYlVLdGg5SnN3RnJn)


I use active admin to quickly create simple UI for Admin and User. If Admin: can edit all items, 
else normal user can't not view and edit users and products, just make orders and order_details

## The API

Same logic with the website

| Method    | API                                | Sample params                                                                                                | Description                        | User role |
|-----------|------------------------------------|--------------------------------------------------------------------------------------------------------------|------------------------------------|-----------|
| POST      | /api/v1/users(.:format)            | {,"user": {,"email": "aa@gmail.com",,"password": "aa@gmail.com",,"password_confirmation": "aa@gmail.com",} } | register new user                  | All       |
| POST      | /api/v1/users/login(.:format)      | {,"user": {,"email": "aa@gmail.com",,"password": "aa@gmail.com",}                                            | login                              | All       |
| PATCH/PUT | /api/v1/users/:id(.:format)        | {,"user": {,"email": "aa@gmail.com",,"password": "aa@gmail.com",}                                            | update user                        | Admin     |
| GET       | /api/v1/orders(.:format)           |                                                                                                              | get list of orders                 | All       |
| POST      | /api/v1/orders(.:format)           | {,"order": {,"name": "first order",} }                                                                       | create new order                   | All       |
| PATCH/PUT | /api/v1/orders/:id(.:format)       | {,"order": {,"name": "first order",}}                                                                        | update order                       | All       |
| DELETE    | /api/v1/orders/:id(.:format)       |                                                                                                              | delete order                       | All       |
| GET       | /api/v1/products(.:format)         |                                                                                                              | get list of products               | All       |
| POST      | /api/v1/products(.:format)         | {,"product": {,"name": "Television 2",,"price": 12,} }                                                       | create new product                 | Admin     |
| PUT/PATCH | /api/v1/product/:id(.:format)      | {,"product": {,"name": "Television 2",,"price": 12,}}                                                        | update product                     | Admin     |
| DELETE    | /api/v1/product/:id(.:format)      |                                                                                                              | delete product                     | Admin     |
| GET       | /api/v1/order_details(.:format)    | example: /api/v1/orders_details?order_id=1                                                                   | get list of order details by order | All       |
| POST      | /api/v1/order_details(.:format)    | {,"order_detail": {,"order_id": 1,,"product_id": 1,,"amount": 1,} }                                          | create new order details           | All       |
| PUT/PATCH | /api/v1/order_detail/:id(.:format) | {,"order_detail": {,"order_id": 1,,"product_id": 1,,"amount": 1,}}                                           | update order details               | All       |
| DELETE    | /api/v1/order_detail/:id(.:format) |                                                                                                              | delete order details               | All       |


To easy test I create a collection by postman, You can install and import by link:
https://www.getpostman.com/collections/a11e592beebad69c1111


![alt text](./Screen%20Shot%202018-04-20%20at%2010.16.39%20PM.png?raw=true)

But if you want to test, remember set environment of postman first. You can import the sample environment from file 'getlinks_test_environment.postman_environment.json'
(locate on project folder)




## Test

I use rspec to cover some test of API controller, to test run command:  `rspec`


