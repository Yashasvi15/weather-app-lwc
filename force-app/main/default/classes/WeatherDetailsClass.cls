public class WeatherDetailsClass {

    @AuraEnabled
    public static WeatherDetailsWrapper getWeatherDetails(String cityName) {
        //Frame the Enpoint URL
        String apikey = '<API Key>';
        String endpoint ='http://api.openweathermap.org/data/2.5/weather';
        endpoint += '?q='+cityName;
        endpoint += '&units=metric';
        endpoint += '&APPID='+apiKey;
        System.debug('endpoint url=>'+endpoint);
        
        //Callout to Weather API
        Http http = new http();
        HttpRequest req = new HttpRequest();
        req.setEndPoint(endpoint);
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        system.debug('response status ->'+ res);
        system.debug('response body ->' +JSON.deserializeUntyped(res.getBody()));
        
        //return the weather details in wrapper form
        WeatherDetailsWrapper weatherDet = new WeatherDetailsWrapper();
        if(res.getStatusCode()==200)
        {

            Map<String,Object> result = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
            weatherDet.city = String.valueOf(result.get('name'));
            Map<String,Object> mainResult = (Map<String,Object>)(result.get('main'));
            weatherDet.temperature = String.valueOf(mainResult.get('temp'));
            weatherDet.pressure = String.valueOf(mainResult.get('pressure'));
            weatherDet.humidity = String.valueOf(mainResult.get('humidity'));
            weatherDet.feelsLike = String.valueOf(mainResult.get('feels_Like'));
            weatherDet.tempMin = String.valueOf(mainResult.get('temp_min'));
            weatherDet.tempMax =String.valueOf(mainResult.get('temp_max'));


        }
        System.debug('weather details to return ->' +weatherDet);
        return weatherDet;
    }
//Wrapper class to store weather details in serial manner
  public class WeatherDetailsWrapper {
    @AuraEnabled public String city {get;set;}
    @AuraEnabled public String temperature {get;set;}
    @AuraEnabled public String pressure {get;set;}
    @AuraEnabled public String humidity {get;set;}
    @AuraEnabled public String feelsLike {get;set;}
    @AuraEnabled public String tempMin {get;set;}
    @AuraEnabled public String tempMax {get;set;}
  }

}
