import UIKit
import mParticle_Apple_SDK

class InspectorDataSourceProvider: NSObject, MPListenerProtocol {
    public var allData = AllSectionData(title: "", rows: [])
    public var apiUsage = AllSectionData(title: "API Usage", rows: [])
    public var databaseState = AllSectionData(title: "Database State", rows: [])
    public var networkUsage = AllSectionData(title: "Network Usage", rows: [])

    required override init() {
        super.init()
    }
    
    /**
     * Indicates that an API method was called. This includes invocations both from external sources (your code)
     * and those which originated from within the SDK
     * @param apiName the name of the Api method
     * @param stackTrace is the current stackTrace as an array of NSStrings
     * @param isExternal true, if the call originated from outside of the SDK
     * @param objects is the arguments sent to this api, such as the MPEvent in logEvent
     */
    internal func onAPICalled(_ apiName: String, stackTrace: [Any], isExternal: Bool, objects: [Any]?) {
        let stackTraceLine: String = (stackTrace[1] as! String)
        let trimmedString = stackTraceLine.components(separatedBy: "[")[1].trimmingCharacters(in: .whitespacesAndNewlines)
        let apiSubstring = trimmedString.components(separatedBy: apiName)[0]
        let callingAPI = String(apiSubstring).trimmingCharacters(in: .whitespacesAndNewlines)
        
        let newData = AllRowData(title: "\(callingAPI).\(apiName)", body: stackTrace.description)
        
        self.apiUsage.rows.append(newData)
        self.allData.rows.append(newData)
    }
    
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {c

    
    /**
     * Indicates that a new Database entry has been created
     * @param tableName the name of the table
     * @param primaryKey a unique identifier for the database row
     * @param message the database entry in JSON form
     */
    internal func onEntityStored(_ tableName: MPDatabaseTable, primaryKey: NSNumber, message: String) {
        let tableType: String
        switch tableName {
        case MPDatabaseTable.attributes:
            tableType = "Attributes"
        case MPDatabaseTable.breadcrumbs:
            tableType = "Breadcrumbs"
        case MPDatabaseTable.messages:
            tableType = "Messages"
        case MPDatabaseTable.reporting:
            tableType = "Reporting"
        case MPDatabaseTable.sessions:
            tableType = "Sessions"
        case MPDatabaseTable.uploads:
            tableType = "Uploads"
        case MPDatabaseTable.unknown:
            tableType = "Unknown"
        default:
            tableType = "Unknown"
        }
        
        let newData = AllRowData(title: "_id: \(primaryKey), \(tableType) Table", body: message.description)
        
        self.databaseState.rows.append(newData)
        self.allData.rows.append(newData)
    }
    
    /**
     * Indicates that a Network Request has been started. Network Requests for a given Endpoint are performed
     * synchronously, so the next invocation of onNetworkRequestFinished of the same Endpoint will be linked
     * @param type the type of network request, see Endpoint
     * @param url the URL of the request
     * @param body the response body in JSON form
     */
    internal func  onNetworkRequestStarted(_ type: MPEndpoint, url: String, body: NSObject) {
        let title: String
        switch type {
        case MPEndpoint.identityLogin:
            title = "Identity.Login"
        case MPEndpoint.identityLogout:
            title = "Identity.Logout"
        case MPEndpoint.identityIdentify:
            title = "Identity.Identify"
        case MPEndpoint.identityModify:
            title = "Identity.Modify"
        case MPEndpoint.events:
            title = "Events"
        case MPEndpoint.config:
            title = "Config"
        default:
            title = ""
        }
        
        var bodyDictionary = NSDictionary.init()
        if ((body as? NSDictionary) != nil) {
            bodyDictionary = body as! NSDictionary
        }
        
        let newData = AllRowData(title: title, body: "URL: \(url) \nBody: \(bodyDictionary.description)")
        newData.isNetworkRequest = true
        newData.expandable = true

        self.networkUsage.rows.append(newData)
        self.allData.rows.append(newData)
    }
    
    /**
     * Indicates that a Network Request has completed. Network Requests for a given Endpoint are performed
     * synchronously, so any invocation will refer to the same request as the most recent onNetworkRequestStarted
     * @param type the type of network request, see Endpoint
     * @param url the URL of the request
     * @param body the response body in JSON form
     * @param responseCode the HTTP response code
     */
    internal func  onNetworkRequestFinished(_ type: MPEndpoint, url: String, body: NSObject, responseCode: Int) {
        let title: String
        switch type {
        case MPEndpoint.identityLogin:
            title = "Identity.Login"
        case MPEndpoint.identityLogout:
            title = "Identity.Logout"
        case MPEndpoint.identityIdentify:
            title = "Identity.Identify"
        case MPEndpoint.identityModify:
            title = "Identity.Modify"
        case MPEndpoint.events:
            title = "Events"
        case MPEndpoint.config:
            title = "Config"
        default:
            title = ""
        }
        
        var bodyDictionary = NSDictionary.init()
        if ((body as? NSDictionary) != nil) {
            bodyDictionary = body as! NSDictionary
        }
        
        let newData = AllRowData(title: title, body: "URL: \(url) \nBody: \(bodyDictionary.description) \nResponse Code: \(responseCode.description)")
        newData.isNetworkRequest = true
        newData.networkRequestComplete = true
        let success = responseCode == 200 || responseCode == 202
        newData.networkRequestFailed = !success
        
        if let recentRequest = self.networkUsage.rows.last, recentRequest.title == title, !recentRequest.networkRequestComplete {
            newData.previousData = self.networkUsage.rows.removeLast()
            self.networkUsage.rows.append(newData)
            self.allData.rows.removeLast()
            self.allData.rows.append(newData)
        }
    }
    
    /**
     * to be called when a Kit's API method is invoked, and the name of the Kit's method is different
     * than the method containing this method's invocation
     * @param methodName the name of the Kit's method being called
     * @param kitId the Id of the kit
     * @param used whether the Kit's method returned ReportingMessages, or null if return type is void
     * @param objects the arguments supplied to the Kit
     */
    internal func onKitApiCalled(_ methodName: String, kitId: Int32, used: Bool, objects: [Any]) {
        
    }
    
    /**
     * Indicates that a Kit module, with kitId, is present in the classpath
     * @param kitId the id of the kit, corresponse with a {@link com.mparticle.MParticle.ServiceProviders}
     */
    internal func onKitDetected(_ kitId: Int32) {
        
    }
    
    /**
     * Indicates that a Configuration for a kit with kitId is being applied
     * @param kitId the id of the kit, corresponse with a {@link com.mparticle.MParticle.ServiceProviders}
     * @param configuration the kit
     */
//    private func onKitConfigRecieved(_ kitId: Int32, configuration: NSDictionary) {
//
//    }
    
    /**
     * Indicates that a kit with kitId was successfully started
     * @param kitId the id of the kit, corresponse with a {@link com.mparticle.MParticle.ServiceProviders}
     */
    internal func onKitStarted(_ kitId: Int32) {
        
    }
    
    /**
     * Indicates that either an attempt to start a kit was unsuccessful, or a started kit was stopped.
     * Possibilities for why this may happen include: {@link MParticleUser}'s loggedIn status or
     * {@link com.mparticle.consent.ConsentState} required it to be stopped, the Kit crashed, or a
     * configuration was received with excluded the kit
     * @param kitId the id of the kit, corresponse with a {@link com.mparticle.MParticle.ServiceProviders}
     * @param reason a message containing the reason a kit was stopped
     */
    internal func onKitExcluded(_ kitId: Int32, reason: String) {
        
    }
    
    /**
     * Indicates that state of a Session may have changed
     * @param session the current {@link InternalSession} instance
     */
//    private func on
//    - (void)onSessionUpdated:(nullable MPSession *)session {
//
//    }

    
}
