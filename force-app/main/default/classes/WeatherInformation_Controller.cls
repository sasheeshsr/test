public class WeatherInformation_Controller {
    
    @AuraEnabled
    public Static weatherwrapper getweatherInformation(Decimal let,Decimal longt,Boolean iscity){
        System.debug('sam  '+let+'    '+longt+'    '+iscity);
        
        String userciry 		= [SELECT Id,City FROM User WHERE Id=:Userinfo.getUserId()].City;
        HTTP http 				= new HTTP();
        HttpRequest request 	= new HttpRequest();
        HttpResponse response 	= new HttpResponse();
        String key 				=   Weatherinfoconstant.key; //'a40b2dc16bcce4c88823b278f68bf7b1';
        String cityloc  		= EncodingUtil.urlEncode(userciry, 'UTF-8');
        cityloc					= iscity ? cityloc : ''+let +','+ longt;	
        String endpointURL 		= 'http://api.weatherstack.com/current?query='+cityloc+'&access_key='+key;
        
        request.setMethod('GET');
        request.setEndpoint(endpointURL);
        request.setTimeout(120000);
        request.setHeader('Content-Type', 'application/json');
        response				=	http.send(request);
        System.debug(response.getBody());
        Map<String,Object> resultMAP = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
        Map<String, Object> currobjs = (Map<String, Object> )resultMAP.get('current');
        
        Map<String, Object> currlocobjs = (Map<String, Object> )resultMAP.get('location');
        
        
        weatherwrapper obj    	 = 	new weatherwrapper();
        obj.locname			  	 =	iscity ? userciry : (String)currlocobjs.get('name');
        obj.todaydate 			 = 	(String)((DateTime.valueOf(currlocobjs.get('localtime')+':00')).format('EEEE MMMM dd, YYYY K:mm a'));//''+Datetime.now().format('EEEE MMMM dd, YYYY K:mm a');

        obj.temperature 	 	 =	(Decimal)currobjs.get('temperature');
        obj.observation_time 	 =	(String)currobjs.get('observation_time');
        List<Object> weathericon = 	(List<Object>)currobjs.get('weather_icons');
        obj.weather_icons		 =	(String)weathericon[0];
        List<Object> weatherdesc = 	(List<Object>)currobjs.get('weather_descriptions');
        obj.weather_descriptions =	(String)weatherdesc[0];
        obj.humidity 			 =	(Decimal)currobjs.get('humidity');
        obj.wind 				 =	(Decimal)currobjs.get('wind_speed');
        obj.precip 				 =	(Decimal)currobjs.get('precip');
        return obj;
    }
    
    public class weatherwrapper{
        @AuraEnabled
        public String locname 				{get; set;} 
        @AuraEnabled
        public String todaydate 			{get; set;} 
        @AuraEnabled
        public String observation_time 		{get; set;} 
        @AuraEnabled
        public Decimal temperature 			{get; set;} 
        @AuraEnabled
        public String weather_icons 		{get; set;} 
        @AuraEnabled
        public String weather_descriptions	{get; set;} 
        @AuraEnabled
        public Decimal humidity 			{get; set;} 
        @AuraEnabled
        public Decimal wind 				{get; set;} 
        @AuraEnabled
        public Decimal precip 				{get; set;} 
     }

}