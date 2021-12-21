---------------------------------
-- Signatures
---------------------------------
sig StringVar {}
sig Date {}
sig Time {}
sig DateTime {}
sig Coordinates {}
sig GeographicalExtension {}
sig ForecastData {}
sig SensorType {}
sig SensorDataPayload {}

sig UserID {}
sig Email {}
sig Password {}
sig Username {}

sig ProductID {}

sig SuggestionID {}

sig HelpRequestID {}
abstract sig HReqStatus {}
sig PENDING extends HReqStatus {}
sig OPEN extends HReqStatus {}
sig CLOSED extends HReqStatus {}
abstract sig HReqSeverity {}
sig LOW extends HReqSeverity {}
sig MEDIUM extends HReqSeverity {}
sig HIGH extends HReqSeverity {}

sig TerrainID {}

sig AreaID {}

sig ForecastID {}

sig ReportID {}

sig SensorID {}

abstract sig Product {
	productId: ProductID,
	name: StringVar,
}
sig AgrProduct extends Product {}
sig AuxProduct extends Product {}

abstract sig User {
	userID: UserID,
	email: one Email,
	username: Username,
	password: Password,
}

sig Farmer extends User {}
sig PolicyMaker extends User {} {
	one this.~supervisor // each policy maker has one and one only area to monitor
	}

sig Area {
	areaID: AreaID,
	name: StringVar,
	supervisor: one PolicyMaker,  // each area is monitored by one and one only policy maker
	coordinates: Coordinates
}

sig Terrain {
	terrainID: TerrainID,
	area: Area,
	owner: one Farmer, // each terrain is associate with one and only farmer
	coordinates: Coordinates,
	extension: GeographicalExtension,
}

sig Sensor {
	sensorID: SensorID,
	terrain: Terrain,
	type: SensorType
}

sig SensorData {
	sensor: Sensor,
	date: one Date,
	payload: SensorDataPayload
}

sig WeatherForecast {
	forecastID: ForecastID,
	area: Area,
	date: Date,
	forecastData: set ForecastData
}

sig Production {
	product: AgrProduct,
	quantity: Int,
	auxiliaryProducts: some AuxProduct
}

sig Report {
	reportID: ReportID,
	date: one Date,
	creator: one Farmer,
	problems: set StringVar,
	productions: some Production,
	forecast: set ForecastID,
	sensorData: set SensorData
}

sig HelpRequest {
	helpRequestID: HelpRequestID,
	creator: one Farmer,
	managedBy: lone PolicyMaker,
	severity: HReqSeverity,
	status: HReqStatus,
	creationDate: one Date,
	openingDate: one Date,
	closureDate: one Date
}

sig Suggestion {
	suggestionId: SuggestionID,
	product: Product,
	date: Date
}

sig TopFarmers {
	winners: some Farmer,
	area: Area,
	prize: some Prize
}

sig Prize {
	amount: Int,
	winner: one Farmer,
	assignee: one PolicyMaker
}

---------------------------------
-- Facts
---------------------------------

fact uniqueUserIDs {
	no disj u1, u2: User | u1.userID = u2.userID
}

fact noUserIDWithoutUser {
	all uid: UserID | one u: User |  u.userID = uid
}

fact uniqueProductIDs {
	no disj p1, p2: Product | p1.productId = p2.productId
}

fact noProductIDWithoutProduct {
	all pid: ProductID | one p: Product |  p.productId = pid
}

fact uniqueSensorIDs {
	no disj s1, s2: Sensor | s1.sensorID = s2.sensorID
}

fact noSensorIDWithoutSensor {
	all sid: SensorID | one s: Sensor |  s.sensorID = sid
}

fact uniqueSuggestionIDs {
	no disj s1, s2: Suggestion | s1.suggestionId = s2.suggestionId
}

fact noSuggIDWithoutSuggestion {
	all sid: SuggestionID | one s: Suggestion |  s.suggestionId = sid
}

fact uniqueTerrainIDs {
	no disj t1, t2: Terrain | t1.terrainID = t2.terrainID
}

fact noTerrainIDWithoutTerrain {
	all tid: TerrainID | one t: Terrain |  t.terrainID = tid
}

fact noExtWithoutTerrain {
	all ge: GeographicalExtension | one t: Terrain | t.extension = ge
}

fact uniqueAreaIDs {
	no disj a1, a2: Area | a1.areaID = a2.areaID
}

fact noAreaIDwithoutArea {
	all aid: AreaID | one a: Area |  a.areaID = aid
}

fact uniqueHelpRequestIDs {
	no disj h1, h2: HelpRequest | h1.helpRequestID = h2.helpRequestID
}

fact noHReqIDWithoutHReq {
	all hid: HelpRequestID | one h: HelpRequest |  h.helpRequestID = hid
}

fact noHreqStatusWithoutHReq{
	all hS: HReqStatus | one h: HelpRequest |  h.status = hS
}

fact noSeverityWithoutHReq {
	all hS: HReqSeverity | one h: HelpRequest | h.severity = hS
}

fact uniqueReportIDs {
	no disj r1, r2: Report | r1.reportID = r2.reportID
}

fact noReportIDWithoutReport {
	all rid: ReportID | one r: Report |  r.reportID = rid
}

fact noNegativeQuantity {
	all p: Production | p.quantity > 0
}

fact uniqueUserEmail {
	no disj u1, u2: User | u1.email = u2.email
}

fact noEmailWithoutUser {
	all e: Email | one u: User |  u.email = e
}

fact uniqueUsernames {
	no disj u1, u2: User | u1.username = u2.username
}

fact noUsernameWithoutUser {
	all uname: Username | one u: User | u.username = uname
}

fact noPasswordWithoutUser {
	all psw: Password | one u: User | u.password = psw
}

fact noFarmerWithoutTerrain {
	all f: Farmer | one t: Terrain | t.owner = f
}

fact noFIDWithoutForecast {
	all fid: ForecastID | one f: WeatherForecast | f.forecastID = fid
}

fact noFDataWithoutForecast {
	all fd: ForecastData | one f: WeatherForecast | f.forecastData = fd
}

fact noStypeWithoutSensor {
	all stype: SensorType | one s: Sensor | s.type = stype
}

fact noPayloadWithoutSData {
	all sdp: SensorDataPayload | one sd: SensorData | sd.payload = sdp
}

// se il farmer è nella top 10 dell'area, allora un premio sarà assegnato a farmer dal policy maker dell'area
fact farmerAwarding {
	all farmer: Farmer, top: TopFarmers, prize: Prize |
	(farmer in top.winners) implies ((farmer in top.prize.winner) and (prize.assignee in top.area.supervisor))
}

---------------------------------
-- Predicates
---------------------------------
pred world1 {
	#PolicyMaker = 1
	#Farmer = 1
	#Report = 1
}
run world1 for 5