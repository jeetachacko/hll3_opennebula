'use strict';
class getValues {

     static workerActualRate() {
          var wactualrate = [100, 100, 100, 100, 100, 100, 100, 100, 100, 100]
          return wactualrate;
     }
     static workerLearnedRate() {
          var wlearnedrate = [60, 60, 60, 60, 60, 60, 60, 60, 60, 60]
          return wlearnedrate;
     }
     static workerMaxRate() {
          var wmaxrate = [500, 500, 500, 500, 500, 500, 500, 500, 500, 500]
          return wmaxrate;
     }

}

module.exports = getValues;

