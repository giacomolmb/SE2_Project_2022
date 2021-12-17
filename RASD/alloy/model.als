sig Date {}
sig Time {}
sig DateTime {}
sig Coordinates {}
sig GeographicalExtension {}
sig ForecastData {}

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

sig TerrainID {}

sig AreaID {}

sig ForecastID {}

sig ReportID {}

sig ProductID {}

abstract sig Product {
	productId: ProductID,
	name: String,
	description: String,
	category: String
}
one sig AgriculturalProduct extends Product {}
one sig AuxiliaryProduct extends Product {
	brand: String
}

abstract sig User {
	userID: UserID,
	name: String,
	surname: String,
	email: Email,
	username: Username,
	password: Password
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

sig WeatherForecast {
	forecastID: ForecastID,
	area: Area,
	date: Date,
	forecastData: ForecastData
}

sig Production {
	product: AgriculturalProduct,
	quantity: Int,
	auxiliaryProducts: some AuxiliaryProducts
}

sig Report {
	reportID: ReportID,
	date: Date,
	creator: Farmer,
	problems: set String,
	productions: some Production,
	forecast: set ForecastID
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
