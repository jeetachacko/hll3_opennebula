'use strict';
class getValues {

     static workloadType() {
          //workloadType values: 0==PlayHeavy, 1==CalculateRevenueHeavy
          var workloadType = 0
          return workloadType
     }
     static functionType() {
          //functionType values: 0==Vanilla, 1==Delta
          var functionType = 1
          return functionType
     }

}

module.exports = getValues;

