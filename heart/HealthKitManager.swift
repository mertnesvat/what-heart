import HealthKit

final class HealthKitManager {
    static let shared = HealthKitManager()
    var healthStore = HKHealthStore()
    
    func requestAuth() {
        let sampleTypes = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!,
                               HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!,
                               HKSeriesType.heartbeat()])
        
        // Request permission to read and write heart rate and heartbeat data.
        healthStore.requestAuthorization(toShare: sampleTypes, read: sampleTypes) { (success, error) in
            print("Request Authorization -- Success: ", success, " Error: ", error ?? "nil")
            // Handle authorization errors here.
        }
    }
    
    func readData() {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
        let startDate = formatter.date(from: "01/08/2019")
        let endDate = Date()
        
        
        let type = HKSampleType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRateVariabilitySDNN)
        let predicate = HKQuery.predicateForSamples(withStart: startDate,
                                                    end: endDate,
                                                    options: HKQueryOptions.strictEndDate)
        
        let query = HKSampleQuery(sampleType: type!,
                      predicate: predicate,
                      limit: 0,
                      sortDescriptors: nil) { (query, results, error) in
                        if let res = results, error == nil {
                            for sample in res {
                                let level = (sample as! HKDiscreteQuantitySample).quantity
                                print("\(level) --- Start : \(sample.startDate) - End : \(sample.endDate)")
                            }
                        }
        }
        
        self.healthStore.execute(query)
    }
}
