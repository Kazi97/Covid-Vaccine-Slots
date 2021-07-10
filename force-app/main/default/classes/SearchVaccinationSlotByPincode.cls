public with sharing class SearchVaccinationSlotByPincode {
    
    @AuraEnabled
    public static Map<String,Object> getVaccineSlotsByPincode(String pincode, String todaysDate){

        String url = 'https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByPin?pincode='+pincode+'&date='+todaysDate;
        
        System.debug(url);

        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');

        Map<String,Object> vaccineSlotData = new Map<String,Object>();
        String result = null;

        try{
            Http http = new Http();
            HttpResponse response = http.send(request);
            System.debug(response.getStatusCode());

            if(response.getStatusCode() == 200){
                result = response.getBody();
            }else{
                throw new CalloutException(response.getBody());
            }
        }catch(Exception e){
            throw e;
        }

        if(!String.isBlank(result)){
            vaccineSlotData = (Map<String,Object>)JSON.deserializeUntyped(result);
        }

        system.debug(vaccineSlotData);

        if(!vaccineSlotData.isEmpty()){
            return vaccineSlotData;
        }else{
            return null;
        }

    }
}