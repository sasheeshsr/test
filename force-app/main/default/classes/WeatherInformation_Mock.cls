@isTest
global class WeatherInformation_Mock implements HttpCalloutMock{
	global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"current": {"observation_time": "12:35 PM","temparature": 16,"weather_code": 122,"weather_icons": ["https://assets.weatherstack.com/images/symbol.png"],"weather_descriptions": ["Overcast"],"wind_speed": 17,"pressure": 1016,"precip": 0,"humidity": 87,"cloudcover": 100}}');
        response.setStatusCode(200);
        return response; 
    }
}