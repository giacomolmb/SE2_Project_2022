---------------------------------
-- Signatures
---------------------------------

sig Date {}
sig Time {}
sig DateTime {}
sig Coordinates {}
sig GeographicalExtension {}
sig ForecastData {}
sig SensorDataPayload {}

sig UserID {}
sig Email {}
sig Password {}
sig Username {}

sig ProductID {}

sig SuggestionID {}

sig HelpRequestID {}
abstract sig HReqStatus {}
one sig PENDING extends HReqStatus {}
one sig OPEN extends HReqStatus {}
one sig CLOSED extends HReqStatus {}
abstract sig HReqSeverity {}
one sig LOW extends HReqSeverity {}
one sig MEDIUM extends HReqSeverity {}
one sig HIGH extends HReqSeverity {}

sig TerrainID {}

sig AreaID {}

sig ForecastID {}

sig ReportID {}

sig SensorID {}

sig Product {
	productId: ProductID,
	name: String,
	description: String,
	category: String
}

abstract sig User {
	userID: UserID,
	name: String,
	surname: String,
	email: Email,
	username: Username,
	password: Password,
	dateOfBirth: Date
}

one sig Farmer extends User {}
one sig PolicyMaker extends User {}

sig Area {
	areaID: AreaID,
	name: String,
	coordinates: Coordinates
}

sig Terrain {
	terrainID: TerrainID,
	area: Area,
	owner: Farmer,
	coordinates: Coordinates,
	extension: GeographicalExtension,
}

sig Sensor {
	sensorID: SensorID,
	terrain: Terrain,
	type: String
}

sig SensorData {
	sensor: Sensor,
	date: Date,
	payload: SensorDataPayload
}

sig WeatherForecast {
	forecastID: ForecastID,
	area: Area,
	date: Date,
	forecastData: ForecastData
}

sig Production {
	product: Product,
	quantity: Int,
	auxiliaryProducts: some Product
}

sig Report {
	reportID: ReportID,
	date: Date,
	creator: Farmer,
	problems: set String,
	productions: some Production,
	forecast: set ForecastID,
	sensorData: set SensorData
}

sig HelpRequest {
	helpRequestID: HelpRequestID,
	creator: Farmer,
	managedBy: lone PolicyMaker,
	severity: HReqSeverity,
	status: HReqStatus,
	creationDate: Date,
	openingDate: Date,
	closureDate: Date
}

sig Suggestion {
	suggestionId: SuggestionID,
	description: String,
	product: Product,
	date: Date
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

fact uniqueReportIDs {
	no disj r1, r2: Report | r1.reportID = r2.reportID
}

fact noReportIDWithoutReport {
	all rid: ReportID | one r: Report |  r.reportID = rid
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

fact noAreaWithoutTerrains {
	all a: Area | some t: Terrain | t.area = a
}

---------------------------------
-- Predicates
---------------------------------
pred world1 {
	#UserID = 1
	#Email = 1
	#Farmer = 1
}
run world1 for 5
