## robotframework-api-authenticationType
robotframework-api-authenticationType is a project that helps to learn about different API authentication types and writing the test for each types in RobotFramework.

### Table of Contents

#### [Prerequisites](#prereq)
#### 1. [Definitions](#def)
>>  ##### 1.1 [What is Authentication?](#authenticationDefinition)
>>  ##### 1.2 [What is Authorization?](#authorizationDefinition)
>>  ##### 1.3 [What is API?](#apiDefinition)
#### 2. [Types of Authentications](#typesOfAuth)
#### 3. [NO Authentication](#noAuth)
#### 4. [Basic Authentication](#basicAuth)
#### 5. [API Key Authentication](#apiKey)
#### 6. [OAuth (Bearer) Authentication](#oauthBearer)

#####   Prerequisites <a name="prereq"></a>
1.  Need to install robotframework and request library
    ```
    pip install robotframework
    pip install robotframework-requests
    ```
2.  Need to understand basic Get/Post request.

#####  1. Definitions <a name="def"></a>
>   *1.1 What is Authentication?<a name="authenticationDefinition"></a>*
    
>   Normally, a web service needs to know to whom it's providing the service. Thus the API consumers must authenticate themselves—proving that “they are who they say they are” via various authentication methods. A good authentication method protects the sensitive information exchanged between the client and the server. Thus, Authentication is when an entity proves an identity. In other words, Authentication proves that you are who you say you are. This is like having a driver license which is given by a trusted authority that the requester, such as a police officer, can use as evidence that suggests you are in fact who you say you are.

>   *1.2 What is Authorization?<a name="authorizationDefinition"><a/>*

>   Authorization is an entirely different concept and in simple terms, Authorization is when an entity proves a right to access. In other words, Authorization proves you have the right to make a request. Consider the following - You have a working key card that allows you to open only some doors in the work area, but not all of them.

>   In summary: 
>>  Authentication: Refers to proving correct identity (Who you are)

>>>  Authorization: Refers to allowing a certain action (What you can do)
 
>   *1.3 What is API?<a name="apiDefinition"><a/>*

>   An API is a set of programming code that enables data transmission between one software product and another. It also contains the terms of this data exchange.
>   In Simple term, an API is a messenger that takes requests and tells the system what you want to do and returns the response back to you.

##### 2. Types of Authentications<a name="typesOfAuth">
There are three most common method to perform authentication request with an API.
1. Basic Authentication
2. API keys
3. OAuth (Bearer) Authentication
There are also api where we don't need authentication. (No Auth)

##### 3. NO Authentication <a name="noAuth"><a/>
While most APIs require access via API keys (which are similar to passwords), or have complex methods of authentication and authorization, there are also quite a few APIs with no requirements at all.
Lets try this out. This is really simple and easy to begin with.
Run [No_auth.robot](/Authentication_type/no_auth.robot) testfile.
```
robot Authentication_type\no_auth.robot 
```
Also, you can check the curl request:
```curl
curl https://api.publicapis.org/random?auth=null
```

##### 4. Basic Authentication <a name="basicAuth"><a/>
You send your username/password alongside every API call. Basic Authentication is the least secure of the supported authentication mechanisms. Your credentials are not encrypted or hashed; they are Base64-encoded only.
So, Nowadays, Basic authentication has been deprecated and instead of Basic Authentication mostly use is OAuth (Bearer) Authentication.
For sample test, you can run the [basic_authentication.robot](/Authentication_type/basic_authentication.robot) test file.

```
robot Authentication_type\basic_authentication.robot
```

Test Cases:
1. Basic Authentication to login using username and Password.
    >   This is sample example of Basic Authentication, where we are sending Post request with Username and Password.
           
    > Also, you can check the curl request as:
    ```curl
    curl -d "username=eve.holt@reqres.in&password=cityslicka" https://reqres.in/api/login
    ```

1. Basic Authentication to login Github using username and Password.
    >   This is sample example of Basic Authentication, where we are sending Get request with Username and Password.
           
    > Also, you can check the curl request as: (need to change username and password)
    ```curl
    curl -u "nl.shrestha90@gmail.com:Password" https://api.github.com/user/repos
    ```

1. Basic Authentication to login Github using Basic Authorization token.
    >   This is above same example of Basic Authentication, where we are sending Get request with Authorization token.

    > For this we need to take "username:password" and encode it into base64 format. The output should be used in header section of request as "Authorization=Basic ${base64_encoded_token}".
     Steps:      
    > * Go to https://www.base64encode.org/
    > * Paste: nl.shrestha90@gmail.com:Password
    > ![encode_base64](ss/encode_base64.jpg)
    > * Click encode and copy value and paste in header authorization token of get request.
    
    > Also, you can check the curl request as: (need to change username and password)

    ```curl
    curl -H "Authorization: Basic ${base64_encoded_token}" https://api.github.com/user/repos
    ```

##### 5. API Key Authentication <a name="apiKey"><a/>

The service creates a unique key for your account and you pass it alongside every request.
For this, we are going to generate API key for google map places.

##### 5.1 Generate API key for Google Map Places:
 
Follow steps mentioned in site " https://developers.google.com/places/web-service/get-api-key#get_key " or below steps to generate apiKey:
* Go to site: https://console.cloud.google.com/google/maps-apis/overview
* Click on dropdown as shown in screenshot and create New project.
![create_project_dropdown](ss/apikey/create_project_dropdown.jpg) 
![create_new_project](ss/apikey/create_new_project.jpg) 
* Give a desired Project name and Click on "Create" button.
![project_name](ss/apikey/project_name.jpg)
* Go to created project. Click the menu button  and select APIs & Services > Credentials.
![menu_credentials](ss/apikey/menu_credentials.jpg)
* On the Credentials page, click Create credentials > API key.
The API key created dialog displays your newly created API key.
![create_credentials](ss/apikey/create_credentials.jpg)
* Click Close. The new API key is listed on the Credentials page under API keys.

After this,we need to enable API & Services for Places.
* Go to your project Dashboard and click on "Enable API & Services"
![enable_api_services](ss/apikey/enable_api_services.jpg)
* Search "places" and click Places API
![click_places_api](ss/apikey/click_places_api.jpg)
* enable places api
![enable_places_api](ss/apikey/enable_places_api.jpg)

Now, we are ready to hit the API.

For sample test, you can run the [keyapi_authentication.robot](/Authentication_type/keyapi_authentication.robot) test file.
```
robot Authentication_type\keyapi_authentication.robot
```
Note: *You must enable Billing on the Google Cloud Project at https://console.cloud.google.com/project/_/billing/enable to see the exact response data information*

*else you will get the response but no exact places value which should work fine for testing purpose*

Also, you can check the curl request as:
```
curl -G -d "location=-33.8670522,151.1957362&radius=500&types=food&name=harbour&key=AIzaSyCUEj_LqR74fK16C8bkK9mlY7QQKKc6Z6g" https://maps.googleapis.com//maps/api/place/nearbysearch/json
```

##### 6. OAuth (Bearer) Authentication <a name="oauthBearer"><a/>
Authentication scheme that involves security tokens called bearer tokens. The client must send this token in the Authorization header when making requests to protected resources: Authorization: Bearer {token}

A user clicks on a sign-in button, grants permission, and your app can authenticate each request with an access_token.

For this, we are going to use petfinder.com api to get Bearer token. We need to first create an account on it and follow the below steps.
###### Steps to Get clientId and client_secret to request access token.
-   After you create an account on petfinder, go to https://www.petfinder.com/developers/
-   Scroll down and Click on "get an API key"
![petfinder_getapi](ss/oauth_api/petfinder_getapi.jpg)
-   Enter the app name and app url. You can enter any.
![petfinder_software_appform](ss/oauth_api/petfinder_software_appform.jpg)
-   Then , you will get API Keys & Secret, Copy that. You can also found these keys in your account --> Developer Settings.
![petfinder_keys](ss/oauth_api/petfinder_keys.jpg)
- After this we can get access token using these keys. You can check https://www.petfinder.com/developers/v2/docs/ documents for more detail.

Now, we have got ClientID and client_secret keys, we can start our test.

For sample test, you can check code & run the [oauth_bearer_authentication.robot](/Authentication_type/oauth_bearer_authentication.robot) test file.
```
robot Authentication_type\oauth_bearer_authentication.robot
```
This includes 
- Requesting to get a Bearer access token which is done in KW : GET OAUTH ACCESS TOKEN FOR THE PETFINDER API
- Using the response access token in Authorization: Bearer ${token} in header section of other API to get request from server.

To get a token, make the following request, replacing {CLIENT-ID} and {CLIENT-SECRET} with your own information:
```curl
curl -d "grant_type=client_credentials&client_id={CLIENT-ID}&client_secret={CLIENT-SECRET}" https://api.petfinder.com/v2/oauth2/token
```
The server will send back a access token response, which need to be include in the header of every API request until session expires. 


---

---
##### References

https://github.com/public-apis/public-apis

https://idratherbewriting.com/learnapidoc/docapis_more_about_authorization.html

https://www.petfinder.com/developers/v2/docs/

---
---

If you have any questions / suggestions / comments on the report, please feel free to reach me at
 - Email: <a href="mailto:nl.shrestha90@gmail.com?Subject=API-Authentications-RFTest" target="_blank">`nl.shrestha90@gmail.com`</a> 
 - LinkedIn: <a href="https://www.linkedin.com/in/anilshrestha-19890307/" target="_blank">`Anil Kumar Shrestha`</a>

---


:star: repo if you like it.
