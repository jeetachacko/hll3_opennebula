'use strict';
class getValues {

     static workerActualRate() {
          var wactualrate = [100, 100, 100, 100, 100, 100, 100, 100, 100, 100]
          return wactualrate;
     }
     static workerLearnedRate() {
          var wlearnedrate = [70, 70, 70, 70, 70, 100, 100, 100, 100, 100]
          return wlearnedrate;
     }
     static workerMaxRate() {
          var wmaxrate = [300, 300, 300, 300, 300, 300, 300, 300, 300, 300]
          return wmaxrate;
     }

}

module.exports = getValues;

