import { LightningElement, track } from 'lwc';
import getVaccineSlotsByPincode from '@salesforce/apex/SearchVaccinationSlotByPincode.getVaccineSlotsByPincode';

export default class SearchSlotByPincode extends LightningElement {

    @track pincode
    @track currentDate
    @track centers
    @track showSlots = false

    pincodeHandler(event) {
        this.pincode = event.target.value
    }

    dateHandler(event) {
        var tempDate = event.target.value;
        this.currentDate = tempDate.split("-").reverse().join("-")
    }

    clickHandler() {
        console.log(this.pincode)
        console.log(this.currentDate)

        getVaccineSlotsByPincode({pincode : this.pincode, todaysDate : this.currentDate}).then(response => {
            this.centers = response.centers
            this.showSlots = true
            console.log(response);
        }).catch(error => {
            this.showSlots = false
            console.error(error)
        })

    }
}