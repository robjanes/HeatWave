
// Project: DopeWars 
// Created: 2017-11-01
// Authors: Robert Janes, Richard Bannerman

// show all errors
SetErrorMode(2)


//Screen Dimension Variables
global ScreenWidth as Integer = 1136
global ScreenHeight as Integer = 640

// set window properties
SetWindowTitle( "Heat Wave" )
SetWindowSize( ScreenWidth, ScreenHeight, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( ScreenWidth, ScreenHeight ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 30, 0 ) // 30fps instead of 60 to save battery
//SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts


//======Resources========
dim Resource[5] as String

//======Vars=============
global i as integer

//======Objectives=======
type ObjectiveRec
	ShowAtLocation as Integer
	ShowAtCash as Integer
	LabelString as String 
endtype

//Number of Objectives
global NumObjectives as Integer

//Set the Maximum Number of Objectives
global MaxObjectives as Integer = 99

//Define the Objectives
dim Objective[MaxObjectives] as ObjectiveRec

//======Player===========
type PlayerRec
	Sprite as Integer
	X as Integer
	Y as Integer
	MaxItems as Integer
	MinItems as Integer
	Resource1Amount as Integer
	Resource2Amount as Integer
	Resource3Amount as Integer
	Resource4Amount as Integer
	Resource5Amount as Integer
	Resource6Amount as Integer
	Resource7Amount as Integer
	Resource8Amount as Integer
	Resource9Amount as integer
	CurrentLocation as Integer
	LastLocation as Integer
	LastBuyLocation as Integer
	LastSellLocation as Integer
	Cash as Integer
	CurrentObjective as Integer
	CurrentMilestone as Integer
	CurrentPhoneMessage as Integer
	StashCash as Integer
	Stash1Min as Integer
	Stash1Max as Integer
	Stash2Min as Integer
	Stash2Max as Integer
	Stash3Min as Integer
	Stash3Max as Integer
	Stash4Min as Integer
	Stash4Max as Integer
	Stash5Min as Integer
	Stash5Max as Integer
	Stash6Min as Integer
	Stash6Max as Integer
	Stash7Min as Integer
	Stash7Max as Integer
	Stash8Min as Integer
	Stash8Max as Integer
	Stash9Min as Integer
	Stash9Max as Integer
	Debug as Integer
	Debt as Integer
	Energy as Integer
	CurrentMessage as Integer
	TutorialState as Integer
	NumBusted as integer
	Day as Integer
endtype

global Player as PlayerRec

//======Locations========
type LocationRec
	Name as string 
	Texture as string 
	Sprite as Integer
	Music as String
	Resource1Price as Integer
	Resource2Price as Integer
	Resource3Price as Integer
	Resource4Price as Integer
	Resource5Price as Integer
	BuyTexture as String
	BuySprite as Integer
	BuyX as Integer
	BuyY as Integer
	BuyWidth as Integer
	BuyHeight as Integer
	SellTexture as String
	SellSprite as Integer
	SellX as Integer
	SellY as Integer
	SellWidth as Integer
	SellHeight as Integer
	HospitalTexture as String
	HospitalSprite as Integer
	HospitalX as Integer
	HospitalY as Integer
	HospitalWidth as Integer
	HospitalHeight as Integer
	AirportTexture as String
	AirportSprite as Integer
	AirportX as Integer
	AirportY as Integer
	AirportWidth as Integer
	AirportHeight as Integer
	MapTexture as String
	MapSprite as Integer
	MapX as Integer
	MapY as Integer
	MapWidth as Integer
	MapHeight as Integer
	MapLabel as Integer
	PlayerX as Integer
	PlayerY as Integer
	BuyLabel as Integer
	SellLabel as Integer
	AirportLabel as Integer
	HospitalLabel as Integer
	BuyString as string 
	SellString as String
	AirportString as String
	HospitalString as String
	BuyVisible as Integer
	SellVisible as Integer
	HospitalVisible as Integer
	CashNeededToBeVisible as Integer
	LocationType as Integer
	Resource1 as Integer
	Resource2 as Integer
	Resource3 as Integer
	Resource4 as Integer
	Resource5 as Integer
	CurrentHeat as Integer
	Sell1 as integer
	Sell2 as integer
	Sell3 as integer
	Sell1Price as Integer
	Sell2Price as Integer
	Sell3Price as Integer
	SellResource1Name as String 
	SellResource2Name as String
	SellResource3Name as String
	
endtype

//Set the Maximum Number of Locations
global MaxLocations as Integer = 99

//Set the Number of Locations
global NumLocations as Integer

//Define the Locations
dim Location[MaxLocations] as LocationRec

//======Routes===========
//======Each Route Array will be Loaded Dynamically when a Scene is Loaded//
Dim RouteDestination[MaxLocations] as Integer
Dim RouteTime[MaxLocations] as Integer
Dim RouteCost[MaxLocations] as Integer

//======Buttons==========
type ButtonRec
	X as Integer
	Y as Integer
	Width as Integer
	Height as Integer
	Sprite as Integer
	Texture as String
	Label as Integer
	LabelString as String 
endtype

//======Messages=========
global CurrentMessageID as integer
global CurrentMessageTitle as String 
global CurrentMessageEntries as integer
dim CurrentMessageEntry[10] as String 
global CurrentMessageEntryCounter as Integer

//Current Number of Buttons Loaded from Buttons.dat
global NumButtons as integer

//Labels for Message Window
global LabelMessageTitle as integer
global LabelMessageBody as Integer


//Set the Maximum Size of the Button Array
global MaxButtons as Integer = 99

//Declare Button Array
dim Button[MaxButtons] as ButtonRec

//Declare Button IDs
global ButtonNewGame as integer = 1
global ButtonContinue as integer = 2
global ButtonCredits as integer = 3
global ButtonMessages as integer = 4
global ButtonNews as integer = 5
global ButtonMainMenu as integer = 6
global ButtonAcceptObjective as Integer = 7
global ButtonCancelMap as integer = 8
global ButtonCancelLocation as Integer = 9
global ButtonGoToLocation as Integer = 10
global ButtonStash as Integer = 11
global ButtonBustedContinue as Integer = 12
global ButtonSleep as integer = 13

//======File IO==========
global FileID as integer
global FileName as string
global strRawData as String
global strParsedData as String

//======Temporary Cached Image=======
global tmpImage as integer

//======Mouse Input==================
global pX as integer
global pY as integer
global wX as integer
global wY as integer
global LastViewTop as Integer
global LastViewLeft as integer

type FallingItemRec
	Sprite as Integer
	X as integer
	Y as Integer
	Speed as Integer
	Active as integer
endtype

dim FallingItem[100] as FallingItemRec

//======Game States==================
global GameState as Integer
global GameStateMainMenu as Integer = 1
global GameStateNewGame as Integer = 2
global GameStateInScene as Integer = 3
global GameStateObjective as Integer = 4
global GameStateMap as integer = 5
global GameStateLocationOptions as Integer = 6
global GameStateSellScene as Integer = 7
global GameStateSelling as integer = 8
global GameStateBuyScene as integer = 9
global GameStateItsTheCops as Integer = 10
global GameStateRunIntro as Integer = 11
global GameStateRunAway as integer = 12
global GameStateMoving as Integer = 13
global GameStateMessage as integer = 14
global GameStateBusted as integer = 15
global GameStateSleep as integer = 16

//======Views========================
global ViewBackground as integer
global ViewForeground as integer
global ViewClouds as integer
global ViewTitle as integer
global ViewObjective as Integer
global ViewMap as integer
global ViewArrow as integer
global ViewMapLogo as integer
global ViewBackgroundScene as Integer
global ViewEnergyIcon as Integer
global ViewRunningBackground as integer
global ViewRunningBackgroundBlank as integer
global ViewRunning as Integer
global ViewMessage as integer

dim ImageRunning[10] as integer
global ViewItsTheCops as Integer

dim ViewEnergy[10] as Integer

dim ImageMoving[24] as Integer
global ViewMoving as Integer

//======Image Constants===============
global ImageBackgroundMainMenu as integer
global ImageForegroundMainMenu as integer
global ImageClouds as integer
global ImageTitle as integer
global ImagePlayer as integer
global ImageMap as integer
global ImageBackgroundObjective as Integer
global ImageCancel as Integer
global ImageArrow as integer
global ImageMapLogo as integer
global ImageBackgroundScene as integer
global ImageCheckboxBlank as integer
global ImageCheckboxChecked as integer
global ImageButtonSell as integer
global ImageButtonBuy as integer
global ImageRunningBackground as integer
global ImageRunningBackgroundBlank as integer
global ImageItsTheCops1 as Integer
global ImageItsTheCops2 as Integer
global ImageButtonBounce as integer
global ImageHeatbarBackground as Integer
global ImageHeatbarForeground as Integer
global ImageButtonStopSelling as Integer
global ImageSliderBackground as integer
global ImageSliderForeground as integer
global ImageEnergyIcon as Integer
global ImageEnergyGlyph as Integer
global ImageTapInactive as Integer
global ImageTapActive as integer
global ImageLeftActive as Integer
global ImageRightActive as Integer
global ImageLeftInactive as Integer
global ImageRightInactive as integer
global ImageBackgroundMessage as integer
global ImageHoverBed as integer
global ImageHoverMessages as Integer
global ImageHoverDoor as integer
global CurrentSecond as integer
global LastSecond as integer
global Difference as integer
global ImageLocationDot as Integer

//=====Labels==================
global LabelObjective as Integer

//=====View Offset=====================
global ViewTop as integer
global ViewLeft as integer

//=====Counters=========================
global Tick as Integer
global CloudX as integer
global CloudY as integer
global Clicked as Integer

//=====Fonts=============================
global GameFont as Integer

//Difference for Screen Dragging
global DifferenceTouchX as integer
global DifferenceTouchY as integer
global OriginalTouchX as integer
global OriginalTouchY as integer
global DragScreenDown as integer
global OriginalViewTop as integer
global OriginalViewLeft as integer

//Labels on the Map Page
global LabelEnergy as integer
global LabelMoney as integer
global LabelPack as integer
global LabelTitleEnergy as integer
global LabelTitleMoney as integer
global LabelTitlePack as integer

//For Tracking Date/Date
global Hour as Integer
global Minute as Integer
global LabelTime as Integer
global NumDays as Integer

//Storing the current location
global CurrentLocation as integer
global ItsTheCopsTimer as Integer
global ItsTheCopsX as Integer
global ItsTheCopsY as Integer

//Location Types
global LocationTypeSell as Integer = 1
global LocationTypeBuy as Integer = 2

//Tmp String used to Store Data
global tmpString as String 

global SellResource1 as Integer
global SellResource2 as Integer
global SellResource3 as Integer 
global SellResource4 as Integer
global SellResource5 as integer
global BuyResource1 as Integer
global BuyResource2 as Integer
global BuyResource3 as integer
global BuyResource4 as integer
global BuyResource5 as integer
global BuyResource1Amount as integer
global BuyResource2Amount as Integer
global BuyResource3Amount as Integer
global BuyResource4Amount as Integer
global BuyResource5Amount as integer
global CopsUIHeat as Integer
global CopsUILeftButton as Integer
global CopsUIRightButton as Integer
global HeatbarWidth as integer
global CurrentDay as integer
global HeatMultiplier as integer
dim SellResource[5] as Integer
dim SellPrice[5] as Integer
global ViewLocationDot as Integer

global ImageBustedBackground as integer
global ImageBusted as integer
global ViewBustedBackground as integer
global ViewBusted as integer
global LabelBusted as Integer
global ImageGameOver as integer


//Scene GUI Variables
//These are stored separately from the Location Variables
//These values get updated dynamically depending upon the location
//that the user is visiting
type SceneGUIRec
	LocationNameLabel as Integer
	LocationTypeLabel as Integer
	LocationTypeAlpha as Integer
	LocationTypeDirection as integer
	LocationActionLabel as Integer
	ResourceNameLabel as Integer
	ResourcePriceLabel as Integer
	Resource1NameLabel as Integer
	Resource1PriceLabel as Integer
	Resource1Checkbox as Integer
	Resource2NameLabel as Integer
	Resource2PriceLabel as Integer
	Resource2Checkbox as Integer
	Resource3NameLabel as Integer
	Resource3PriceLabel as Integer
	Resource3Checkbox as Integer
	Resource4NameLabel as Integer
	Resource4PriceLabel as Integer
	Resource4Checkbox as Integer
	Resource5NameLabel as Integer
	Resource5PriceLabel as Integer
	Resource5Checkbox as Integer
	Resource1Type as Integer
	Resource2Type as Integer
	Resource3Type as Integer
	Resource4Type as Integer
	Resource5Type as Integer
	BuyButton as Integer
	SellButton as Integer
	StopSellingButton as Integer
	StopBuyingButton as Integer
	BounceButton as Integer
	Background as Integer
	HeatbarBackground as Integer
	HeatbarForeground as Integer
	SoldLabel as Integer
	SoldLabelDirection as Integer
	SoldLabelAlpha as Integer
	SoldLabelY as integer
	SoldLabelX as integer
	ProcessLabel as Integer
	ProcessTitleLabel as Integer
	HeatLabel as Integer
	PlayerCashLabel as Integer
	Slider1Background as Integer
	Slider2Background as Integer
	Slider3Background as Integer
	MoneyLabel as Integer
	
	Slider1 as Integer
	Slider2 as Integer
	Slider3 as Integer

	Slider1X as Integer
	Slider2X as Integer
	Slider3X as Integer

	FreeSpaceLabel as Integer
	BuyingSpaceLabel as Integer
	PackLabel as Integer
endtype

global SceneUI as SceneGUIRec
global SellTick as Integer
global CurrentSaleTotal as integer
global CurrentSale as integer
global CurrentSaleAmount as integer
global AddHeat as integer
global OldHeatbarWidth as integer
global NewHeatbarWidth as integer

global CurrentTap as Integer
global TapTick as integer

global CurrentBuy as integer
global CurrentBuyTotal as Integer
global Chance as Integer
global LastSpin as Integer
global ScrollbarDown as Integer
global ScrollBarID as Integer
global BuyAmount1 as Integer
global BuyAmount2 as Integer
global BuyAmount3 as integer
global SliderDown as integer
global SliderID as Integer
global Slider1Offset as Integer
global Slider2Offset as Integer
global Slider3Offset as Integer
global AvailablePack as Integer
global BuyPack as integer
global BuyAmount1Price as Integer
global BuyAmount2Price as Integer
global BuyAmount3Price as integer
global BuyAmountTotal as integer
global CopsAngle as Integer
global CopsWidth as Integer
global CopsHeight as Integer
global DidSwitch as Integer
global TicksPassed as Integer
global CurrentDistance as integer
global CurrentDifference as Integer
global OldDistance as Integer
global DistanceDirection as integer
global SpawnID as integer
global SpawnTick as integer
global NextSpawnTick as Integer
global RunMode as Integer
global MoveDistance as Integer

global SoundClick as Integer
global SoundBuy as Integer
global SoundSell as Integer
global SoundFart as Integer
global SoundRunning as Integer
global SoundMap as Integer
global SoundLocation as Integer

//Hover Objects for the Home Screen
global ViewHoverBed as Integer
global ViewHoverMessages as Integer
global ViewHoverDoor as Integer

//Musics
global MusicMap as Integer 
global MusicLocation as Integer 
global MusicChase as Integer
global MusicSelling as Integer 
global MusicTitle as integer

global EnergyAlpha as Integer
global MovingX as Integer
global MovingY as Integer
global IsMoving as Integer
global tmpLocation as integer

global ImageGotAway as integer
global ViewGotAway as Integer
global GotAwayAlpha as integer

//Record the Last Window we came from
global LastWindow as Integer
global IntroVideo as integer
global Cost as Integer
global GameOver = 0
global ImageBackgroundSleep as Integer
global ViewBackgroundSleep as Integer
global SleepAlpha as Integer
global SleepDirection as integer

//Tutorial popup
global ImageTutorial as integer
global ViewTutorial as integer
global LabelTutorial as Integer
global TutorialX as Integer
Global TutorialY as Integer

global LabelDays as Integer

//Creating Falling Items
function CreateFallingItems()
	for i = 1 to 100
		FallingItem[i].X = 0
		FallingItem[i].Y = 0
		FallingItem[i].Active = 0
		FallingItem[i].Sprite = CreateSprite(ImageRightInactive)
		FallingItem[i].Speed = 0
	next i
	
endfunction

//Stop playing any music
function StopAllMusic()
	
	if LastWindow = GameStateMessage
		exitfunction
	endif
	
	if GetMusicPlayingOGG(MusicTitle) = 1
		StopMusicOGG(MusicTitle)
	endif
	
	if GetMusicPlayingOGG(MusicMap) = 1
		StopMusicOGG(MusicMap)
	endif
	if GetMusicPlayingOGG(MusicLocation) = 1
		StopMusicOGG(MusicLocation)
	endif
	if GetMusicPlayingOGG(MusicChase) = 1
		StopMusicOGG(MusicChase)
	endif
	if GetMusicPlayingOGG(MusicSelling) = 1
		StopMusicOGG(MusicSelling)
	endif
endfunction

//Spawn a random falling item
function SpawnFallingItem()
	SpawnID = 0
	for i = 1 to 100
		if SpawnID = 0
			if FallingItem[i].Active = 0
				SpawnID = i
			endif
		endif
	next i
	if SpawnID > 0
		Chance = Random(1,2)
		if Chance = 1
			SetSpriteImage(FallingItem[SpawnID].Sprite,ImageLeftInactive)
			FallingItem[SpawnID].X = ViewLeft + 50
			FallingItem[SpawnID].Y = ViewTop - 100
			FallingItem[SpawnID].Speed = Random(5,10)
			FallingItem[SpawnID].Active = 1
			SetSpritePosition(FallingItem[SpawnID].Sprite,FallingItem[SpawnID].X,FallingItem[SpawnID].Y)
			SetSpriteDepth(FallingItem[SpawnID].Sprite,1)
			if RunMode = 0
				SetSpriteVisible(FallingItem[SpawnID].Sprite,1)
			endif
		endif
		
		if Chance = 2
			SetSpriteImage(FallingItem[SpawnID].Sprite,ImageRightInactive)
			FallingItem[SpawnID].X = ViewLeft + 950
			FallingItem[SpawnID].Y = ViewTop -100
			FallingItem[SpawnID].Speed = Random(5,10)
			FallingItem[SpawnID].Active = 1
			SetSpritePosition(FallingItem[SpawnID].Sprite,FallingItem[SpawnID].X,FallingItem[SpawnID].Y)
			SetSpriteDepth(FallingItem[SpawnID].Sprite,1)
			if RunMode = 0
				SetSpriteVisible(FallingItem[SpawnID].Sprite,1)
			endif
		endif
		NextSpawnTick = NextSpawnTick + 5
		SpawnTick = 100 - NextSpawnTick
		if SpawnTick <= 20
			SpawnTick = 20
		endif
		
	endif
	
endfunction

//Load Musics
function LoadMusics()
	MusicMap = LoadMusicOGG("Music/Map.ogg")
	SetMusicVolumeOGG(MusicMap,50)
	MusicLocation = LoadMusicOGG("Music/Location.ogg")
	SetMusicVolumeOGG(MusicLocation,50)
	MusicChase = LoadMusicOGG("Music/Chase.ogg")
	SetMusicVolumeOGG(MusicChase,50)
	MusicSelling = LoadMusicOGG("Music/Selling.ogg")
	SetMusicVolumeOGG(MusicSelling,50)
	MusicTitle = LoadMusicOGG("Music/Title.ogg")
	SetMusicVolumeOGG(MusicTitle,50)
	
	SoundClick = LoadSound("Music/Click.wav")
	SoundBuy = LoadSound("Music/Buy.wav")
	SoundSell = LoadSound("Music/Sell.wav")
	SoundFart = LoadSound("Music/Fart.wav")
endfunction

//Load Images
function LoadImages()
	ImageTitle = LoadImage("Title.png")
	ImageClouds = LoadImage("Clouds.png")
	ImageBackgroundMainMenu = LoadImage("BackgroundMainMenu.png")
	ImageForegroundMainMenu = LoadImage("ForegroundMainMenu.png")
	ImagePlayer = LoadImage("Player.png")
	GameFont = LoadFont("Instructions.ttf")
	ImageBackgroundObjective = LoadImage("BackgroundObjective.png")
	ImageMap = LoadImage("Map.png")
	ImageCancel = LoadImage("Cancel.png")
	ImageArrow = LoadImage("Arrow.png")
	ImageMapLogo = LoadImage("MapLogo.png")
	ImageBackgroundScene = LoadImage("BackgroundScene.png")
	ImageCheckboxBlank = LoadImage("CheckboxBlank.png")
	ImageCheckboxChecked = LoadImage("CheckboxChecked.png")
	ImageButtonSell = LoadImage("ButtonSell.png")
	ImageButtonBounce = LoadImage("ButtonBounce.png")
	ImageButtonBuy = LoadImage("ButtonBuy.png")
	ImageHeatbarBackground = LoadImage("HeatbarBack.png")
	ImageHeatbarForeground = LoadImage("HeatbarForward.png")
	ImageButtonStopSelling = LoadImage("ButtonStopSelling.png")
	ImageSliderBackground = LoadImage("SliderBackground.png")
	ImageSliderForeground = LoadImage("SliderForeground.png")
	ImageBustedBackground = LoadImage("BustedBackground.png")
	ImageEnergyGlyph = LoadImage("EnergyGlyph.png")
	ImageEnergyIcon = LoadImage("EnergyIcon.png")
	ImageItsTheCops1 = LoadImage("cops_1.png")
	ImageItsTheCops2 = LoadImage("cops_2.png")
	ImageRunning[1] = LoadImage("runsequence_01.png")
	ImageRunning[2] = LoadImage("runsequence_02.png")
	ImageRunning[3] = LoadImage("runsequence_03.png")
	ImageRunning[4] = LoadImage("runsequence_04.png")
	ImageRunning[5] = LoadImage("runsequence_05.png")
	ImageRunning[6] = LoadImage("runsequence_06.png")
	ImageRunning[7] = LoadImage("runsequence_07.png")
	ImageRunning[8] = LoadImage("runsequence_08.png")
	ImageRunning[9] = LoadImage("runsequence_09.png")
	ImageRunning[10] = LoadImage("runsequence_10.png")
	ImageRunningBackground = LoadImage("runsequence_bg.png")
	ImageRunningBackgroundBlank = LoadImage("runsequence_bg_normal.png")
	ImageTapActive = LoadImage("press_active.png")
	ImageTapInactive = LoadImage("press_inactive.png")
	ImageRightActive = LoadImage("right_active.png")
	ImageLeftActive = LoadImage("left_active.png")
	ImageRightInactive = LoadImage("right_inactive.png")
	ImageLeftInactive = LoadImage("left_inactive.png")
	ImageBackgroundMessage = LoadImage("BackgroundMessage.png")
	ImageHoverBed = LoadImage("HoverBed.png")
	ImageHoverDoor = LoadImage("HoverDoor.png")
	ImageHoverMessages = LoadImage("HoverMessages.png")
	ImageMoving[1] = LoadImage("move_01.png")
	ImageMoving[2] = LoadImage("move_02.png")
	ImageMoving[3] = LoadImage("move_03.png")
	ImageMoving[4] = LoadImage("move_04.png")
	ImageMoving[5] = LoadImage("move_05.png")
	ImageMoving[6] = LoadImage("move_06.png")
	ImageMoving[7] = LoadImage("move_07.png")
	ImageMoving[8] = LoadImage("move_08.png")
	ImageMoving[9] = LoadImage("move_09.png")
	ImageMoving[10] = LoadImage("move_10.png")
	ImageMoving[11] = LoadImage("move_11.png")
	ImageMoving[12] = LoadImage("move_12.png")
	ImageMoving[13] = LoadImage("move_13.png")
	ImageMoving[14] = LoadImage("move_14.png")
	ImageMoving[15] = LoadImage("move_15.png")
	ImageMoving[16] = LoadImage("move_16.png")
	ImageMoving[17] = LoadImage("move_17.png")
	ImageMoving[18] = LoadImage("move_18.png")
	ImageMoving[19] = LoadImage("move_19.png")
	ImageMoving[20] = LoadImage("move_20.png")
	ImageMoving[21] = LoadImage("move_21.png")
	ImageMoving[22] = LoadImage("move_22.png")
	ImageMoving[23] = LoadImage("move_23.png")
	ImageMoving[24] = LoadImage("move_24.png")
	ImageLocationDot = LoadImage("locationdot.png")
	ImageGotAway = LoadImage("GotAway.png")
	IntroVideo = LoadVideo("Title_Video.mp4")
	ImageBusted = LoadImage("BustedTitle.png")
	ImageBackgroundSleep = LoadImage("Sleep.png")
	ImageTutorial = LoadImage("TutorialRight.png")
endfunction

//Start the Moving Animation
function StartMoving()
	IsMoving = 0
	EnergyAlpha = 255
	GameState = GameStateMoving
	
endfunction

//Create the Player
function CreatePlayer()
	Player.Sprite = CreateSprite(ImagePlayer)
	SetSpriteVisible(Player.Sprite,0)
endfunction

//Create the Labels
function CreateLabels()
	
	//Create the Location Name Label
	SceneUI.LocationNameLabel = CreateText("Location Name")
	SetTextFont(SceneUI.LocationNameLabel,GameFont)
	SetTextAlignment(SceneUI.LocationNameLabel,0)
	SetTextPosition(SceneUI.LocationNameLabel,60,60)
	SetTextSize(SceneUI.LocationNameLabel,40)
	SetTextMaxWidth(SceneUI.LocationNameLabel,600)
	SetTextVisible(SceneUI.LocationNameLabel,0)
	
	//Create the Location Type Label
	SceneUI.LocationTypeLabel = CreateText("Location Type")
	SetTextFont(SceneUI.LocationTypeLabel,GameFont)
	SetTextAlignment(SceneUI.LocationTypeLabel,0)
	SetTextPosition(SceneUI.LocationTypeLabel,60,80)
	SetTextSize(SceneUI.LocationTypeLabel,28)
	SetTextMaxWidth(SceneUI.LocationTypeLabel,600)
	SetTextVisible(SceneUI.LocationTypeLabel,0)
	SetTextColor(SceneUI.LocationTypeLabel,0,128,128,255)
	
	//Create the Location Action Label
	SceneUI.LocationActionLabel = CreateText("Current Action")
	SetTextFont(SceneUI.LocationActionLabel,GameFont)
	SetTextAlignment(SceneUI.LocationActionLabel,0)
	SetTextPosition(SceneUI.LocationActionLabel,60,100)
	SetTextSize(SceneUI.LocationActionLabel,28)
	SetTextMaxWidth(SceneUI.LocationActionLabel,600)
	SetTextVisible(SceneUI.LocationActionLabel,0)
	
	//Create the ResourceName Label
	SceneUI.ResourceNameLabel = CreateText("What to Sell")
	SetTextFont(SceneUI.ResourceNameLabel,GameFont)
	SetTextAlignment(SceneUI.ResourceNameLabel,0)
	SetTextPosition(SceneUI.ResourceNameLabel,60,100)
	SetTextSize(SceneUI.ResourceNameLabel,28)
	SetTextMaxWidth(SceneUI.ResourceNameLabel,600)
	SetTextVisible(SceneUI.ResourceNameLabel,0)
	SetTextColor(SceneUI.ResourceNameLabel,0,128,128,255)
	
	//Create the ResourcePrice Label
	SceneUI.ResourcePriceLabel = CreateText("Today's Price")
	SetTextFont(SceneUI.ResourcePriceLabel,GameFont)
	SetTextAlignment(SceneUI.ResourcePriceLabel,2)
	SetTextPosition(SceneUI.ResourcePriceLabel,60,100)
	SetTextSize(SceneUI.ResourcePriceLabel,28)
	SetTextMaxWidth(SceneUI.ResourcePriceLabel,600)
	SetTextVisible(SceneUI.ResourcePriceLabel,0)
	SetTextColor(SceneUI.ResourcePriceLabel,0,128,128,255)
	
	//Create the Resource1Name Label
	SceneUI.Resource1NameLabel = CreateText("Resource 1 Name")
	SetTextFont(SceneUI.Resource1NameLabel,GameFont)
	SetTextAlignment(SceneUI.Resource1NameLabel,0)
	SetTextPosition(SceneUI.Resource1NameLabel,60,100)
	SetTextSize(SceneUI.Resource1NameLabel,28)
	SetTextMaxWidth(SceneUI.Resource1NameLabel,600)
	SetTextVisible(SceneUI.Resource1NameLabel,0)
	
	//Create the Resource1Price Label
	SceneUI.Resource1PriceLabel = CreateText("$ 00/G")
	SetTextFont(SceneUI.Resource1PriceLabel,GameFont)
	SetTextAlignment(SceneUI.Resource1PriceLabel,2)
	SetTextPosition(SceneUI.Resource1PriceLabel,60,100)
	SetTextSize(SceneUI.Resource1PriceLabel,28)
	SetTextMaxWidth(SceneUI.Resource1PriceLabel,600)
	SetTextVisible(SceneUI.Resource1PriceLabel,0)
	
	//Create the Resource2Name Label
	SceneUI.Resource2NameLabel = CreateText("Resource 2 Name")
	SetTextFont(SceneUI.Resource2NameLabel,GameFont)
	SetTextAlignment(SceneUI.Resource2NameLabel,0)
	SetTextPosition(SceneUI.Resource2NameLabel,60,100)
	SetTextSize(SceneUI.Resource2NameLabel,28)
	SetTextMaxWidth(SceneUI.Resource2NameLabel,600)
	SetTextVisible(SceneUI.Resource2NameLabel,0)
	
	//Create the Resource2Price Label
	SceneUI.Resource2PriceLabel = CreateText("$ 00/G")
	SetTextFont(SceneUI.Resource2PriceLabel,GameFont)
	SetTextAlignment(SceneUI.Resource2PriceLabel,2)
	SetTextPosition(SceneUI.Resource2PriceLabel,60,100)
	SetTextSize(SceneUI.Resource2PriceLabel,28)
	SetTextMaxWidth(SceneUI.Resource2PriceLabel,600)
	SetTextVisible(SceneUI.Resource2PriceLabel,0)
	
	//Create the Resource3Name Label
	SceneUI.Resource3NameLabel = CreateText("Resource 3 Name")
	SetTextFont(SceneUI.Resource3NameLabel,GameFont)
	SetTextAlignment(SceneUI.Resource3NameLabel,0)
	SetTextPosition(SceneUI.Resource3NameLabel,60,100)
	SetTextSize(SceneUI.Resource3NameLabel,28)
	SetTextMaxWidth(SceneUI.Resource3NameLabel,600)
	SetTextVisible(SceneUI.Resource3NameLabel,0)
	
	//Create the Resource3Price Label
	SceneUI.Resource3PriceLabel = CreateText("$ 00/G")
	SetTextFont(SceneUI.Resource3PriceLabel,GameFont)
	SetTextAlignment(SceneUI.Resource3PriceLabel,2)
	SetTextPosition(SceneUI.Resource3PriceLabel,60,100)
	SetTextSize(SceneUI.Resource3PriceLabel,28)
	SetTextMaxWidth(SceneUI.Resource3PriceLabel,600)
	SetTextVisible(SceneUI.Resource3PriceLabel,0)
	
	//Create the Resource4Name Label
	SceneUI.Resource4NameLabel = CreateText("Resource 4 Name")
	SetTextFont(SceneUI.Resource4NameLabel,GameFont)
	SetTextAlignment(SceneUI.Resource4NameLabel,0)
	SetTextPosition(SceneUI.Resource4NameLabel,60,100)
	SetTextSize(SceneUI.Resource4NameLabel,28)
	SetTextMaxWidth(SceneUI.Resource4NameLabel,600)
	SetTextVisible(SceneUI.Resource4NameLabel,0)
	
	//Create the Resource4Price Label
	SceneUI.Resource4PriceLabel = CreateText("$ 00/G")
	SetTextFont(SceneUI.Resource4PriceLabel,GameFont)
	SetTextAlignment(SceneUI.Resource4PriceLabel,2)
	SetTextPosition(SceneUI.Resource4PriceLabel,60,100)
	SetTextSize(SceneUI.Resource4PriceLabel,28)
	SetTextMaxWidth(SceneUI.Resource4PriceLabel,600)
	SetTextVisible(SceneUI.Resource4PriceLabel,0)
	
	//Create the Resource5Name Label
	SceneUI.Resource5NameLabel = CreateText("Resource 5 Name")
	SetTextFont(SceneUI.Resource5NameLabel,GameFont)
	SetTextAlignment(SceneUI.Resource5NameLabel,0)
	SetTextPosition(SceneUI.Resource5NameLabel,60,100)
	SetTextSize(SceneUI.Resource5NameLabel,28)
	SetTextMaxWidth(SceneUI.Resource5NameLabel,600)
	SetTextVisible(SceneUI.Resource5NameLabel,0)
	
	//Create the Resource5Price Label
	SceneUI.Resource5PriceLabel = CreateText("$ 00/G")
	SetTextFont(SceneUI.Resource5PriceLabel,GameFont)
	SetTextAlignment(SceneUI.Resource5PriceLabel,2)
	SetTextPosition(SceneUI.Resource5PriceLabel,60,100)
	SetTextSize(SceneUI.Resource5PriceLabel,28)
	SetTextMaxWidth(SceneUI.Resource5PriceLabel,600)
	SetTextVisible(SceneUI.Resource5PriceLabel,0)
	
	//Create the Process Title Label
	SceneUI.ProcessTitleLabel = CreateText("Sold:")
	SetTextFont(SceneUI.ProcessTitleLabel,GameFont)
	SetTextAlignment(SceneUI.ProcessTitleLabel,0)
	SetTextPosition(SceneUI.ProcessTitleLabel,60,100)
	SetTextSize(SceneUI.ProcessTitleLabel,40)
	SetTextMaxWidth(SceneUI.ProcessTitleLabel,600)
	SetTextVisible(SceneUI.ProcessTitleLabel,0)
	SetTextColor(SceneUI.ProcessTitleLabel,0,128,128,255)
	
	//Create the Process Label
	SceneUI.ProcessLabel = CreateText("$0")
	SetTextFont(SceneUI.ProcessLabel,GameFont)
	SetTextAlignment(SceneUI.ProcessLabel,2)
	SetTextPosition(SceneUI.ProcessLabel,60,100)
	SetTextSize(SceneUI.ProcessLabel,40)
	SetTextMaxWidth(SceneUI.ProcessLabel,600)
	SetTextVisible(SceneUI.ProcessLabel,0)
	
	//Create the Heat Label
	SceneUI.HeatLabel = CreateText("Heat")
	SetTextFont(SceneUI.HeatLabel,GameFont)
	SetTextAlignment(SceneUI.HeatLabel,0)
	SetTextPosition(SceneUI.HeatLabel,60,100)
	SetTextSize(SceneUI.HeatLabel,40)
	SetTextMaxWidth(SceneUI.HeatLabel,600)
	SetTextVisible(SceneUI.HeatLabel,0)
	SetTextColor(SceneUI.HeatLabel,255,87,126,255)
	
	//Create the Sold Label
	SceneUI.SoldLabel = CreateText("+ $0")
	SetTextFont(SceneUI.SoldLabel,GameFont)
	SetTextAlignment(SceneUI.SoldLabel,0)
	SetTextPosition(SceneUI.SoldLabel,60,100)
	SetTextSize(SceneUI.SoldLabel,28)
	SetTextMaxWidth(SceneUI.SoldLabel,600)
	SetTextVisible(SceneUI.SoldLabel,0)
	
	//Create the Sold Label
	SceneUI.PlayerCashLabel = CreateText("$0")
	SetTextFont(SceneUI.PlayerCashLabel,GameFont)
	SetTextAlignment(SceneUI.PlayerCashLabel,2)
	SetTextPosition(SceneUI.PlayerCashLabel,60,100)
	SetTextSize(SceneUI.PlayerCashLabel,28)
	SetTextMaxWidth(SceneUI.PlayerCashLabel,600)
	SetTextVisible(SceneUI.PlayerCashLabel,0)
	
	//Create the Money Label
	SceneUI.MoneyLabel = CreateText("Money:")
	SetTextFont(SceneUI.MoneyLabel,GameFont)
	SetTextAlignment(SceneUI.MoneyLabel,2)
	SetTextPosition(SceneUI.MoneyLabel,60,100)
	SetTextSize(SceneUI.MoneyLabel,28)
	SetTextMaxWidth(SceneUI.MoneyLabel,600)
	SetTextVisible(SceneUI.MoneyLabel,0)
	
	//Create the Free Space Label
	SceneUI.FreeSpaceLabel = CreateText("0")
	SetTextFont(SceneUI.FreeSpaceLabel,GameFont)
	SetTextAlignment(SceneUI.FreeSpaceLabel,0)
	SetTextPosition(SceneUI.FreeSpaceLabel,60,100)
	SetTextSize(SceneUI.FreeSpaceLabel,28)
	SetTextMaxWidth(SceneUI.FreeSpaceLabel,600)
	SetTextVisible(SceneUI.FreeSpaceLabel,0)
	
	//Create the Buying Space Label
	SceneUI.BuyingSpaceLabel = CreateText("0")
	SetTextFont(SceneUI.BuyingSpaceLabel,GameFont)
	SetTextAlignment(SceneUI.BuyingSpaceLabel,0)
	SetTextPosition(SceneUI.BuyingSpaceLabel,60,100)
	SetTextSize(SceneUI.BuyingSpaceLabel,28)
	SetTextMaxWidth(SceneUI.BuyingSpaceLabel,600)
	SetTextVisible(SceneUI.BuyingSpaceLabel,0)
	
	//Create the Pack Label
	SceneUI.PackLabel = CreateText("0/0")
	SetTextFont(SceneUI.PackLabel,GameFont)
	SetTextAlignment(SceneUI.PackLabel,2)
	SetTextPosition(SceneUI.PackLabel,60,100)
	SetTextSize(SceneUI.PackLabel,28)
	SetTextMaxWidth(SceneUI.PackLabel,600)
	SetTextVisible(SceneUI.PackLabel,0)
	
	//Create the Objective Label
	LabelObjective = CreateText("Placeholder Text")
	SetTextFont(LabelObjective,GameFont)
	SetTextAlignment(LabelObjective,1)
	SetTextPosition(LabelObjective,ScreenWidth / 2,200)
	SetTextSize(LabelObjective,28)
	SetTextMaxWidth(LabelObjective,600)
	SetTextVisible(LabelObjective,0)
	
	//Create the Energy Title on the Map
	LabelTitleEnergy = CreateText("Energy")
	SetTextFont(LabelTitleEnergy,GameFont)
	SetTextPosition(LabelTitleEnergy,20,10)
	SetTextSize(LabelTitleEnergy,28)
	SetTextVisible(LabelTitleEnergy,0)
	
	//Create the Money Title on the Map
	LabelTitleMoney = CreateText("Money")
	SetTextFont(LabelTitleMoney,GameFont)
	SetTextAlignment(LabelTitleMoney,2)
	SetTextPosition(LabelTitleMoney,ScreenWidth - 20,10)
	SetTextSize(LabelTitleMoney,28)
	SetTextVisible(LabelTitleMoney,0)
	
	//Create the Money Label on the Map
	LabelMoney = CreateText("$250")
	SetTextFont(LabelMoney,GameFont)
	SetTextAlignment(LabelMoney,2)
	SetTextPosition(LabelMoney,ScreenWidth - 20,30)
	SetTextSize(LabelMoney,28)
	SetTextVisible(LabelMoney,0)
	SetTextColor(LabelMoney,0,128,128,255)
	
	//Create the Pack Title on the Map
	LabelTitlePack = CreateText("Pack")
	SetTextFont(LabelTitlePack,GameFont)
	SetTextAlignment(LabelTitlePack,2)
	SetTextPosition(LabelTitlePack,ScreenWidth - 120,10)
	SetTextSize(LabelTitlePack,28)
	SetTextVisible(LabelTitlePack,0)
	
	//Create the Pack Label on the Map
	LabelPack = CreateText("100/100")
	SetTextFont(LabelPack,GameFont)
	SetTextAlignment(LabelPack,2)
	SetTextPosition(LabelPack,ScreenWidth - 120,30)
	SetTextSize(LabelPack,28)
	SetTextVisible(LabelPack,0)
	
	
	
	//Create the Message Title Label
	LabelMessageTitle = CreateText("Placeholder Text")
	SetTextFont(LabelMessageTitle,GameFont)
	SetTextAlignment(LabelMessageTitle,1)
	SetTextPosition(LabelMessageTitle,60,100)
	SetTextSize(LabelMessageTitle,28)
	SetTextMaxWidth(LabelMessageTitle,600)
	SetTextVisible(LabelMessageTitle,0)
	SetTextColor(LabelMessageTitle,0,128,128,255)
	
	//Create the Message Title Label
	LabelMessageBody = CreateText("Placeholder Text")
	SetTextFont(LabelMessageBody,GameFont)
	SetTextAlignment(LabelMessageBody,1)
	SetTextPosition(LabelMessageBody,60,100)
	SetTextSize(LabelMessageBody,28)
	SetTextMaxWidth(LabelMessageBody,600)
	SetTextVisible(LabelMessageBody,0)
	SetTextColor(LabelMessageBody,255,255,255,255)

	//Create the Busted label
	LabelBusted = CreateText("Placeholder Text")
	SetTextFont(LabelBusted,GameFont)
	SetTextAlignment(LabelBusted,1)
	SetTextPosition(LabelBusted,60,100)
	SetTextSize(LabelBusted,28)
	SetTextMaxWidth(LabelBusted,600)
	SetTextVisible(LabelBusted,0)
	SetTextColor(LabelBusted,255,255,255,255)
	
	//Create the Days Label
	LabelDays = CreateText("Day: ")
	SetTextFont(LabelDays,GameFont)
	SetTextAlignment(LabelDays,1)
	SetTextPosition(LabelDays,60,100)
	SetTextSize(LabelDays,28)
	SetTextMaxWidth(LabelDays,600)
	SetTextVisible(LabelDays,0)
	SetTextColor(LabelDays,255,255,255,255)

	//Create the Days Label
	LabelTutorial = CreateText("Placeholder Text")
	SetTextFont(LabelTutorial,GameFont)
	SetTextAlignment(LabelTutorial,1)
	SetTextPosition(LabelTutorial,60,100)
	SetTextSize(LabelTutorial,28)
	SetTextMaxWidth(LabelTutorial,350)
	SetTextVisible(LabelTutorial,0)
	SetTextColor(LabelTutorial,255,255,255,255)
		
	//global LabelEnergy as integer
	//global LabelMoney as integer
	//global LabelPack as integer
	//global LabelTitleEnergy as integer
	//global LabelTitleMoney as integer
	//global LabelTitlePack as integer

endfunction

//Create the Views
function CreateViews()
	ViewBackground = CreateSprite(ImageBackgroundMainMenu)
	ViewClouds = CreateSprite(ImageClouds)
	ViewForeground = CreateSprite(ImageForegroundMainMenu)
	ViewTitle = CreateSprite(ImageTitle)
	ViewObjective = CreateSprite(ImageBackgroundObjective)
	ViewMap = CreateSprite(ImageMap)
	ViewArrow = CreateSprite(ImageArrow)
	SetSpriteAnimation(ViewArrow,70,70,4)
	PlaySprite(ViewArrow,8,1,1,4)
	ViewMapLogo = CreateSprite(ImageMapLogo)
	ViewBackgroundScene = CreateSprite(ImageBackgroundScene)
	ViewEnergyIcon = CreateSprite(ImageEnergyIcon)
	for i = 1 to 10
		ViewEnergy[i] = CreateSprite(ImageEnergyGlyph)
	next i
	ViewRunningBackground = CreateSprite(ImageRunningBackground)
	ViewRunningBackgroundBlank = CreateSprite(ImageRunningBackgroundBlank)
	ViewRunning = CreateSprite(ImageRunning[1])
	ViewItsTheCops = CreateSprite(ImageItsTheCops1)
	ViewMessage = CreateSprite(ImageBackgroundMessage)
	ViewHoverBed = CreateSprite(ImageHoverBed)
	ViewHoverMessages = CreateSprite(ImageHoverMessages)
	ViewHoverDoor = CreateSprite(ImageHoverDoor)
	ViewTutorial = CreateSprite(ImageTutorial)
	AddSpriteAnimationFrame(ViewRunning,ImageRunning[1])
	AddSpriteAnimationFrame(ViewRunning,ImageRunning[2])
	AddSpriteAnimationFrame(ViewRunning,ImageRunning[3])
	AddSpriteAnimationFrame(ViewRunning,ImageRunning[4])
	AddSpriteAnimationFrame(ViewRunning,ImageRunning[5])
	AddSpriteAnimationFrame(ViewRunning,ImageRunning[6])
	AddSpriteAnimationFrame(ViewRunning,ImageRunning[7])
	AddSpriteAnimationFrame(ViewRunning,ImageRunning[8])
	AddSpriteAnimationFrame(ViewRunning,ImageRunning[9])
	AddSpriteAnimationFrame(ViewRunning,ImageRunning[10])
	AddSpriteAnimationFrame(ViewItsTheCops,ImageItsTheCops1)
	AddSpriteAnimationFrame(ViewItsTheCops,ImageItsTheCops2)
	
	ViewMoving = CreateSprite(ImageMoving[1])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[1])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[2])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[3])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[4])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[5])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[6])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[7])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[8])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[9])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[10])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[11])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[12])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[13])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[14])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[15])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[16])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[17])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[18])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[19])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[20])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[21])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[22])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[23])
	AddSpriteAnimationFrame(ViewMoving,ImageMoving[24])
	
	//Create the Checkbox for the Scene Resources (Buying or Selling)
	SceneUI.Background = CreateSprite(ImageBackgroundMainMenu)
	SceneUI.Resource1Checkbox =  CreateSprite(ImageCheckboxBlank)
	SceneUI.Resource2Checkbox =  CreateSprite(ImageCheckboxBlank)
	SceneUI.Resource3Checkbox =  CreateSprite(ImageCheckboxBlank)
	SceneUI.Resource4Checkbox =  CreateSprite(ImageCheckboxBlank)
	SceneUI.Resource5Checkbox =  CreateSprite(ImageCheckboxBlank)
	SceneUI.SellButton = CreateSprite(ImageButtonSell)
	SceneUI.BuyButton = CreateSprite(ImageButtonBuy)
	SceneUI.BounceButton = CreateSprite(ImageButtonBounce)
	SceneUI.HeatbarBackground = CreateSprite(ImageHeatbarBackground)
	SceneUI.HeatbarForeground = CreateSprite(ImageHeatbarForeground)
	SceneUI.StopSellingButton = CreateSprite(ImageButtonStopSelling)
	SceneUI.Slider1Background = CreateSprite(ImageSliderBackground)
	SceneUI.Slider2Background = CreateSprite(ImageSliderBackground)
	SceneUI.Slider3Background = CreateSprite(ImageSliderBackground)

	SceneUI.Slider1 = CreateSprite(ImageSliderForeground)
	SceneUI.Slider2 = CreateSprite(ImageSliderForeground)
	SceneUI.Slider3 = CreateSprite(ImageSliderForeground)
	CopsUILeftButton = CreateSprite(ImageLeftInactive)
	CopsUIRightButton = CreateSprite(ImageRightInactive)
	
	ViewGotAway = CreateSprite(ImageGotAway)
	ViewBustedBackground = CreateSprite(ImageBustedBackground)
	ViewBusted = CreateSprite(ImageBusted)
	ViewBackgroundSleep = CreateSprite(ImageBackgroundSleep)
	
endfunction

//Load the Current Message
function LoadMessage(ID as Integer)
	CurrentMessageID = ID
	FileID = OpenToRead("Messages/" + str(CurrentMessageID) + ".dat")
	CurrentMessageEntries = val(ReadLine(FileID))
	CurrentMessageTitle = ReadLine(FileID)
	for i = 1 to CurrentMessageEntries
		CurrentMessageEntry[i] = ReadLine(FileID)
	next i
	
	CloseFile(FileID)
endfunction

//Load Buttons
function LoadButtons()
	FileName = "Config/Buttons.dat"
	FileID = OpenToRead(FileName)
	NumButtons = val(ReadLine(FileID))
	for i = 1 to NumButtons
		strRawData = ReadLine(FileID)
		Button[i].X = val(GetStringToken(strRawData,",",1))
		Button[i].Y = val(GetStringToken(strRawData,",",2))
		Button[i].Texture = GetStringToken(strRawData,",",3)
		Button[i].LabelString = GetStringToken(strRawData,",",4)
		tmpImage = LoadImage(Button[i].Texture)
		Button[i].Sprite = CreateSprite(tmpImage)
		Button[i].Width = GetSpriteWidth(Button[i].Sprite)
		Button[i].Height = GetSpriteHeight(Button[i].Sprite)
		
		Button[i].Label = CreateText(Button[i].LabelString)
		SetTextFont(Button[i].Label,GameFont)
		SetTextAlignment(Button[i].Label,1)
		SetTextPosition(Button[i].Label,Button[i].X + ((Button[i].Width / 4) / 2),Button[i].Y - 20)
		SetTextSize(Button[i].Label,32)
		SetTextVisible(Button[i].Label,0)
		
		SetSpritePosition(Button[i].Sprite, Button[i].X, Button[i].Y)
		SetSpriteVisible(Button[i].Sprite,0)
		
		if i = ButtonMessages
			SetSpriteAnimation(Button[i].Sprite,70,70,4)
		endif
		if i = ButtonNews
			SetSpriteAnimation(Button[i].Sprite,70,70,4)
		endif
		if i = ButtonStash
			SetSpriteAnimation(Button[i].Sprite,70,70,4)
		endif
		if i = ButtonSleep
			SetSpriteAnimation(Button[i].Sprite,70,70,4)
		endif
	next i
	CloseFile(FileID)
	
	
	Button[ButtonAcceptObjective].Label  = CreateText("Next")
	SetTextFont(Button[ButtonAcceptObjective].Label ,GameFont)
	SetTextAlignment(Button[ButtonAcceptObjective].Label ,1)
	SetTextPosition(Button[ButtonAcceptObjective].Label ,60,100)
	SetTextSize(Button[ButtonAcceptObjective].Label ,28)
	SetTextMaxWidth(Button[ButtonAcceptObjective].Label ,600)
	SetTextVisible(Button[ButtonAcceptObjective].Label ,0)
	SetTextColor(Button[ButtonAcceptObjective].Label ,255,255,255,255)
	
	
	Button[ButtonBustedContinue].Label  = CreateText("Continue")
	SetTextFont(Button[ButtonBustedContinue].Label ,GameFont)
	SetTextAlignment(Button[ButtonBustedContinue].Label ,1)
	SetTextPosition(Button[ButtonBustedContinue].Label ,60,100)
	SetTextSize(Button[ButtonBustedContinue].Label ,28)
	SetTextMaxWidth(Button[ButtonBustedContinue].Label ,600)
	SetTextVisible(Button[ButtonBustedContinue].Label ,0)
	SetTextColor(Button[ButtonBustedContinue].Label ,255,255,255,255)
	
endfunction

//Load Objectives
function LoadObjectives()
	FileName = "Objectives/Objectives.dat"
	FileID = OpenToRead(FileName)
	NumObjectives = val(ReadLine(FileID))
	for i = 1 to NumObjectives
		strRawData = ReadLine(FileID)
		Objective[i].ShowAtLocation = val(GetStringToken(strRawData,"|",1))
		Objective[i].ShowAtCash = val(GetStringToken(strRawData,"|",2))
		Objective[i].LabelString = GetStringToken(strRawData,"|",3)
	next i
	CloseFile(FileID)
endfunction

//Load The Resources
function LoadResources()
	FileName = "Resources/Resources.dat"
	FileID = OpenToRead(FileName)
	Resource[1] = ReadLine(FileID)
	Resource[2] = ReadLine(FileID)
	Resource[3] = ReadLine(FileID)
	Resource[4] = ReadLine(FileID)
	Resource[5] = ReadLine(FileID)
	CloseFile(FileID)
	
endfunction

//Load the  Locations
function LoadLocations()
	FileName = "Locations/Locations.dat"
	FileID = OpenToRead(FileName)
	NumLocations = val(ReadLine(FileID))
	for i = 1 to NumLocations
		strRawData = ReadLine(FileID)
		Location[i].Name = GetStringToken(strRawData,",",1)
		Location[i].Texture = GetStringToken(strRawData,",",2)
		Location[i].Music = GetStringToken(strRawData,",",3)
		Location[i].BuyTexture = GetStringToken(strRawData,",",4)
		Location[i].BuyX = val(GetStringToken(strRawData,",",5))
		Location[i].BuyY = val(GetStringToken(strRawData,",",6))
		Location[i].SellTexture = GetStringToken(strRawData,",",7)
		Location[i].SellX = val(GetStringToken(strRawData,",",8))
		Location[i].SellY = val(GetStringToken(strRawData,",",9))
		Location[i].HospitalTexture = GetStringToken(strRawData,",",10)
		Location[i].HospitalX = val(GetStringToken(strRawData,",",11))
		Location[i].HospitalY = val(GetStringToken(strRawData,",",12))
		Location[i].AirportTexture = GetStringToken(strRawData,",",13)
		Location[i].AirportX = val(GetStringToken(strRawData,",",14))
		Location[i].AirportY = val(GetStringToken(strRawData,",",15))
		Location[i].MapTexture = GetStringToken(strRawData,",",16)
		Location[i].MapX = val(GetStringToken(strRawData,",",17))
		Location[i].MapY = val(GetStringToken(strRawData,",",18))
		Location[i].PlayerX = val(GetStringToken(strRawData,",",19))
		Location[i].PlayerY = val(GetStringToken(strRawData,",",20))
		Location[i].BuyVisible = val(GetStringToken(strRawData,",",21))
		Location[i].SellVisible = val(GetStringToken(strRawData,",",22))
		Location[i].HospitalVisible = val(GetStringToken(strRawData,",",23))
		Location[i].CashNeededToBeVisible = val(GetStringToken(strRawData,",",24))
		Location[i].LocationType = val(GetStringToken(strRawData,",",25))
		Location[i].Resource1 = val(GetStringToken(strRawData,",",26))
		Location[i].Resource2 = val(GetStringToken(strRawData,",",27))
		Location[i].Resource3 = val(GetStringToken(strRawData,",",28))
		Location[i].Resource4 = val(GetStringToken(strRawData,",",29))
		Location[i].Resource5 = val(GetStringToken(strRawData,",",30))
		Location[i].Sell1 = val(GetStringToken(strRawData,",",31))
		Location[i].Sell2 = val(GetStringToken(strRawData,",",32))
		Location[i].Sell3 = val(GetStringToken(strRawData,",",33))
		
		tmpImage = LoadImage(Location[i].Texture)
		Location[i].Sprite = CreateSprite(tmpImage)
		tmpImage = LoadImage(Location[i].BuyTexture)
		Location[i].BuySprite = CreateSprite(tmpImage)
		Location[i].BuyWidth = GetSpriteWidth(Location[i].BuySprite)
		Location[i].BuyHeight = GetSpriteHeight(Location[i].BuySprite)
		tmpImage = LoadImage(Location[i].SellTexture)
		Location[i].SellSprite = CreateSprite(tmpImage)
		Location[i].SellWidth = GetSpriteWidth(Location[i].SellSprite)
		Location[i].SellHeight = GetSpriteHeight(Location[i].SellSprite)
		tmpImage = LoadImage(Location[i].HospitalTexture)
		Location[i].HospitalSprite = CreateSprite(tmpImage)
		Location[i].HospitalWidth = GetSpriteWidth(Location[i].HospitalSprite)
		Location[i].HospitalHeight = GetSpriteHeight(Location[i].HospitalSprite)
		tmpImage = LoadImage(Location[i].AirportTexture)
		Location[i].AirportSprite = CreateSprite(tmpImage)
		Location[i].AirportWidth = GetSpriteWidth(Location[i].AirportSprite)
		Location[i].AirportHeight = GetSpriteHeight(Location[i].AirportSprite)
		tmpImage = LoadImage(Location[i].MapTexture)
		Location[i].MapSprite = CreateSprite(tmpImage)
		Location[i].MapWidth = GetSpriteWidth(Location[i].MapSprite)
		Location[i].MapHeight = GetSpriteHeight(Location[i].MapSprite)
		
		Location[i].MapLabel = CreateText(Location[i].Name)
		SetTextFont(Location[i].MapLabel,GameFont)
		SetTextAlignment(Location[i].MapLabel,1)
		SetTextPosition(Location[i].MapLabel,Location[i].MapX + Location[i].MapWidth + 30 ,Location[i].MapY + 20)
		SetTextSize(Location[i].MapLabel,16)
		SetTextVisible(Location[i].MapLabel,0)
		
		Location[i].Resource1Price = 0
		Location[i].Resource2Price = 0
		Location[i].Resource3Price = 0
		Location[i].Resource4Price = 0
		Location[i].Resource5Price = 0

		
		Location[i].BuyString = "Buy"
		Location[i].SellString = "Sell"
		Location[i].AirportString = "To Map"
		Location[i].HospitalString = "Clinic"
		
		Location[i].AirportLabel = CreateText(Location[i].AirportString)
		SetTextFont(Location[i].AirportLabel,GameFont)
		SetTextAlignment(Location[i].AirportLabel,1)
		SetTextPosition(Location[i].AirportLabel,Location[i].AirportX + ((Location[i].AirportWidth / 4) / 2),Location[i].AirportY - 20)
		SetTextSize(Location[i].AirportLabel,32)
		SetTextVisible(Location[i].AirportLabel,0)
		
		Location[i].HospitalLabel = CreateText(Location[i].HospitalString)
		SetTextFont(Location[i].HospitalLabel,GameFont)
		SetTextAlignment(Location[i].HospitalLabel,1)
		SetTextPosition(Location[i].HospitalLabel,Location[i].HospitalX + ((Location[i].HospitalWidth / 4) / 2),Location[i].HospitalY - 20)
		SetTextSize(Location[i].HospitalLabel,32)
		SetTextVisible(Location[i].HospitalLabel,0)
		
		SetSpriteAnimation(Location[i].AirportSprite,70,70,4)
		SetSpriteAnimation(Location[i].HospitalSprite,70,70,4)
		SetSpriteVisible(Location[i].Sprite,0)
		SetSpriteVisible(Location[i].BuySprite,0)
		SetSpriteVisible(Location[i].SellSprite,0)
		SetSpriteVisible(Location[i].HospitalSprite,0)
		SetSpriteVisible(Location[i].AirportSprite,0)
		SetSpriteVisible(Location[i].MapSprite,0)
	next i
	CloseFile(FileID)
endfunction

//Load the Game
function LoadGame()
	FileName = "player.dat"
	if GetFileExists(FileName) = 0
		exitfunction
	endif
	//Only Load the Game if the File Exists!
	if GetFileExists(FileName) = 1
		FileID = OpenToRead(FileName)
		Player.X = val(ReadLine(FileID))
		Player.Y = val(ReadLine(FileID))
		Player.MaxItems = val(ReadLine(FileID))
		Player.MinItems = val(ReadLine(FileID))
		Player.Resource1Amount = val(ReadLine(FileID))
		Player.Resource2Amount = val(ReadLine(FileID))
		Player.Resource3Amount = val(ReadLine(FileID))
		Player.Resource4Amount = val(ReadLine(FileID))
		Player.Resource5Amount = val(ReadLine(FileID))
		Player.Resource6Amount = val(ReadLine(FileID))
		Player.Resource7Amount = val(ReadLine(FileID))
		Player.Resource8Amount = val(ReadLine(FileID))
		Player.Resource9Amount = val(ReadLine(FileID))
		Player.CurrentLocation = val(ReadLine(FileID))
		Player.LastLocation = val(ReadLine(FileID))
		Player.LastBuyLocation = val(ReadLine(FileID))
		Player.LastSellLocation = val(ReadLine(FileID))
		Player.Cash = val(ReadLine(FileID))
		Player.CurrentObjective = val(ReadLine(FileID))
		Player.CurrentMilestone = val(ReadLine(FileID))
		Player.CurrentPhoneMessage = val(ReadLine(FileID))
		Player.StashCash = val(ReadLine(FileID))
		Player.Stash1Min = val(ReadLine(FileID))
		Player.Stash1Max = val(ReadLine(FileID))
		Player.Stash2Min = val(ReadLine(FileID))
		Player.Stash2Max = val(ReadLine(FileID))
		Player.Stash3Min = val(ReadLine(FileID))
		Player.Stash3Max = val(ReadLine(FileID))
		Player.Stash4Min = val(ReadLine(FileID))
		Player.Stash4Max = val(ReadLine(FileID))
		Player.Stash5Min = val(ReadLine(FileID))
		Player.Stash5Max = val(ReadLine(FileID))
		Player.Stash6Min = val(ReadLine(FileID))
		Player.Stash6Max = val(ReadLine(FileID))
		Player.Stash7Min = val(ReadLine(FileID))
		Player.Stash7Max = val(ReadLine(FileID))
		Player.Stash8Min = val(ReadLine(FileID))
		Player.Stash8Max = val(ReadLine(FileID))
		Player.Stash9Min = val(ReadLine(FileID))
		Player.Stash9Max = val(ReadLine(FileID))
		Player.Debug = val(ReadLine(FileID))
		Player.Debt = val(ReadLine(FileID))
		Player.Energy = val(ReadLine(FileID))
		Player.CurrentMessage = val(ReadLine(FileID))
		Player.TutorialState = val(ReadLine(FileID))
		Player.NumBusted = val(ReadLine(FileID))
		Player.Day = val(ReadLine(FileID))
		CloseFile(FileID)
	endif
	Player.Day = Player.Day - 1
	NewDay()
	LastSecond = 0
	CurrentSecond = 0
	ResetTimer()
	GameState = GameStateInScene
	ShowHome()
	
	if Player.CurrentMessage = 1
		//At the very start of the game, let's hide the  GUI buttons
		SetSpriteVisible(Location[1].AirportSprite,0)
		SetTextVisible(Location[1].AirportLabel,0)
		SetSpriteVisible(Button[ButtonMessages].Sprite,0)
		SetTextVisible(Button[ButtonMessages].Label,0)
		NewDay()
		ShowMessage(1)
	endif
	
	
	
endfunction

//Start a New Date
function NewDay()
	CurrentDay = CurrentDay + 1
	Player.Day = Player.Day + 1
	SetTextString(LabelDays,"Day " + str(Player.Day))
	for i = 1 to NumLocations
		
			
		//Reset Heat for Each Location Today
		Location[i].CurrentHeat = 0
		
		//Determine new price that users can sell for each day!
		Location[i].Resource1Price = Random(15,25)
		Location[i].Resource2Price = Random(50,100)
		Location[i].Resource3Price = Random(200,400)
		Location[i].Resource4Price = Random(500,800)
		Location[i].Resource5Price = Random(900,1300)
		
		//Determine new price that thugs are selling for each day!
		Chance = Random(1,5)
		
		//Determine Resource 1 Prices
		if Location[i].Sell1 = 1
			Location[i].Sell1Price = Random(5,10)
		endif
		if Location[i].Sell2 = 1
			Location[i].Sell2Price = Random(5,10)
		endif
		if Location[i].Sell3 = 1
			Location[i].Sell3Price = Random(5,10)
		endif
		
		//Determine Resource 2 Prices
		if Location[i].Sell1 = 2
			Location[i].Sell1Price = Random(15,40)
		endif
		if Location[i].Sell2 = 2
			Location[i].Sell2Price = Random(15,40)
		endif
		if Location[i].Sell3 = 2
			Location[i].Sell3Price = Random(15,40)
		endif
		
		//Determine Resource 3 Prices
		if Location[i].Sell1 = 3
			Location[i].Sell1Price = Random(80,150)
		endif
		if Location[i].Sell2 = 3
			Location[i].Sell2Price = Random(80,150)
		endif
		if Location[i].Sell3 = 3
			Location[i].Sell3Price = Random(80,150)
		endif
		
		//Determine Resource 4 Prices
		if Location[i].Sell1 = 4
			Location[i].Sell1Price = Random(250,400)
		endif
		if Location[i].Sell2 = 4
			Location[i].Sell2Price = Random(250,400)
		endif
		if Location[i].Sell3 = 4
			Location[i].Sell3Price = Random(250,400)
		endif
		
		//Determine Resource 5 Prices
		if Location[i].Sell1 = 5
			Location[i].Sell1Price = Random(500,800)
		endif
		if Location[i].Sell2 = 5
			Location[i].Sell2Price = Random(500,800)
		endif
		if Location[i].Sell3 = 5
			Location[i].Sell3Price = Random(500,800)
		endif
		
		
	next i
	if Player.Day = 30 and Player.Cash < 500000
		GameOver = 2
		Busted()
	endif
	
endfunction

//Save the Game
function SaveGame()
	FileName = "player.dat"
	FileID = OpenToWrite(FileName)
	WriteLine(FileID,str(Player.X))
	WriteLine(FileID,str(Player.Y))
	WriteLine(FileID,str(Player.MaxItems))
	WriteLine(FileID,str(Player.MinItems))
	WriteLine(FileID,str(Player.Resource1Amount))
	WriteLine(FileID,str(Player.Resource2Amount))
	WriteLine(FileID,str(Player.Resource3Amount))
	WriteLine(FileID,str(Player.Resource4Amount))
	WriteLine(FileID,str(Player.Resource5Amount))
	WriteLine(FileID,str(Player.Resource6Amount))
	WriteLine(FileID,str(Player.Resource7Amount))
	WriteLine(FileID,str(Player.Resource8Amount))
	WriteLine(FileID,str(Player.Resource9Amount))
	WriteLine(FileID,str(Player.CurrentLocation))
	WriteLine(FileID,str(Player.LastLocation))
	WriteLine(FileID,str(Player.LastBuyLocation))
	WriteLine(FileID,str(Player.LastSellLocation))
	WriteLine(FileID,str(Player.Cash))
	WriteLine(FileID,str(Player.CurrentObjective))
	WriteLine(FileID,str(Player.CurrentMilestone))
	WriteLine(FileID,str(Player.CurrentPhoneMessage))
	WriteLine(FileID,str(Player.StashCash))
	WriteLine(FileID,str(Player.Stash1Min))
	WriteLine(FileID,str(Player.Stash1Max))
	WriteLine(FileID,str(Player.Stash2Min))
	WriteLine(FileID,str(Player.Stash2Max))
	WriteLine(FileID,str(Player.Stash3Min))
	WriteLine(FileID,str(Player.Stash3Max))
	WriteLine(FileID,str(Player.Stash4Min))
	WriteLine(FileID,str(Player.Stash4Max))
	WriteLine(FileID,str(Player.Stash5Min))
	WriteLine(FileID,str(Player.Stash5Max))
	WriteLine(FileID,str(Player.Stash6Min))
	WriteLine(FileID,str(Player.Stash6Max))
	WriteLine(FileID,str(Player.Stash7Min))
	WriteLine(FileID,str(Player.Stash7Max))
	WriteLine(FileID,str(Player.Stash8Min))
	WriteLine(FileID,str(Player.Stash8Max))
	WriteLine(FileID,str(Player.Stash9Min))
	WriteLine(FileID,str(Player.Stash9Max))
	WriteLine(FileID,str(Player.Debug))
	WriteLine(FileID,str(Player.Debt))
	WriteLine(FileID,str(Player.Energy))
	WriteLine(FileID,str(Player.CurrentMessage))
	WriteLine(FileID,str(Player.TutorialState))
	WriteLine(FileID,str(Player.NumBusted))
	WriteLine(FileID,str(Player.Day))
	CloseFile(FileID)
endfunction

//Reset UI position when dragging
function SetUI()
	ViewLeft = GetViewOffsetX()
	ViewTop = GetViewOffsetY()
	
	SetTextPosition(LabelTitleEnergy,ViewLeft + 20,ViewTop + 10)
	SetTextPosition(LabelTitleMoney,ViewLeft + ScreenWidth - 20, ViewTop + 10)
	SetTextPosition(LabelMoney,ViewLeft + ScreenWidth - 20,ViewTop + 30)
	SetTextDepth(LabelTitleEnergy,1)
	SetSpritePosition(Button[ButtonCancelLocation].Sprite, ViewLeft + 400, ViewTop + 440)
	SetSpritePosition(Button[ButtonGoToLocation].Sprite, ViewLeft + 500, ViewTop + 440)
	SetTextPosition(LabelTitlePack,ViewLeft + ScreenWidth - 120,ViewTop + 10)
	SetTextPosition(LabelPack,ViewLeft + ScreenWidth - 120,ViewTop + 30)
	
	SetSpritePosition(ViewEnergyIcon,ViewLeft + 20,ViewTop + 50)
	SetSpritePosition(ViewEnergy[1], ViewLeft + 50, ViewTop + 55)
	SetSpritePosition(ViewEnergy[2], ViewLeft + 70, ViewTop + 55)
	SetSpritePosition(ViewEnergy[3], ViewLeft + 90, ViewTop + 55)
	SetSpritePosition(ViewEnergy[4], ViewLeft + 110, ViewTop + 55)
	SetSpritePosition(ViewEnergy[5], ViewLeft + 130, ViewTop + 55)
	SetSpritePosition(ViewEnergy[6], ViewLeft + 150, ViewTop + 55)
	SetSpritePosition(ViewEnergy[7], ViewLeft + 170, ViewTop + 55)
	SetSpritePosition(ViewEnergy[8], ViewLeft + 190, ViewTop + 55)
	SetSpritePosition(ViewEnergy[9], ViewLeft + 210, ViewTop + 55)
	SetSpritePosition(ViewEnergy[10], ViewLeft + 230, ViewTop + 55)
	
	
	Button[ButtonCancelLocation].X = ViewLeft + 400
	Button[ButtonCancelLocation].Y = ViewTop + 440
	Button[ButtonGoToLocation].X = ViewLeft + 500
	Button[ButtonGoToLocation].Y = ViewTop + 440
	
	SetSpritePosition(ViewMapLogo,ViewLeft + ((ScreenWidth / 2) - (GetSpriteWidth(ViewMapLogo) / 2)), ViewTop + 10)
	SetSpriteDepth(ViewMapLogo,1)
	SetSpritePosition(ViewGotAway, ViewLeft  + (1136/ 2) - (GetSpriteWidth(ViewGotAway) / 2), ViewTop + (640 / 2) - (GetSpriteHeight(ViewGotAway) / 2))
	SetSpriteDepth(ViewGotAway,0)
	SetTextPosition(LabelDays, ViewLeft + ScreenWidth / 2,ViewTop + 50)
endfunction

//Start Selling Resources
function StartSelling()
	
	if SellResource1 = 0 and SellResource2 = 0 and SellResource3 = 0 and SellResource4 = 0 and SellResource5 = 0
		exitfunction
	endif
	
	if SellResource1 = 1
		if Player.Resource1Amount <= 0
			exitfunction
		endif	
	endif
	if SellResource2 = 1
		if Player.Resource2Amount <= 0
			exitfunction
		endif	
	endif
	if SellResource3 = 1
		if Player.Resource3Amount <= 0
			exitfunction
		endif	
	endif
	if SellResource4 = 1
		if Player.Resource4Amount <= 0
			exitfunction
		endif	
	endif
	if SellResource5 = 1
		if Player.Resource5Amount <= 0
			exitfunction
		endif	
	endif
	
	GameState = GameStateSelling
	StopAllMusic()
	PlayMusicOGG(MusicSelling,1)
	SetSpriteVisible(SceneUI.BounceButton,0)
	SetSpriteVisible(SceneUI.SellButton,0)
	SetSpriteVisible(SceneUI.StopSellingButton,1)
	SetTextString(SceneUI.LocationTypeLabel,"SELLING")
	SceneUI.LocationTypeAlpha = 255
	SceneUI.LocationTypeDirection = 1
	SetTextColor(SceneUI.LocationTypeLabel,255,0,0,SceneUI.LocationTypeAlpha)
	SellTick = 3
	//CurrentSaleTotal = 0
	SetTextString(SceneUI.SoldLabel,"$" + str(CurrentSaleTotal))
	SetTextString(SceneUI.ProcessLabel,"$" + str(CurrentSaleTotal))
	SetSpriteColor(SceneUI.StopSellingButton,200,200,200,255)
	SetSpriteDepth(SceneUI.StopSellingButton,1)
	ResetTimer()
	if Player.TutorialState < 3
		Player.TutorialState = 3
	endif
	

	CurrentSecond = 0
	LastSecond = 0
endfunction

//Stop Selling Resources
function StopSelling()
	GameState = GameStateSellScene
	SetSpriteVisible(SceneUI.BounceButton,1)
	SetSpriteVisible(SceneUI.SellButton,1)
	SetSpriteVisible(SceneUI.StopSellingButton,0)
	SetTextString(SceneUI.LocationTypeLabel,"")
	SceneUI.LocationTypeAlpha = 255
	SceneUI.LocationTypeDirection = 1
	SetTextColor(SceneUI.LocationTypeLabel,0,128,128,SceneUI.LocationTypeAlpha)
	SellTick = 3
	StopAllMusic()
	PlayMusicOGG(MusicLocation,1)
	//CurrentSaleTotal = 0
	SetTextString(SceneUI.ProcessLabel,"$" + str(CurrentSaleTotal))
	SetTextVisible(SceneUI.SoldLabel,0)
	//SetTextString(SceneUI.ProcessLabel,"$" + str(CurrentSaleTotal))
	ResetTimer()
	CurrentSecond = 0
	LastSecond = 0
	SellResource1 = 0
	SellResource2 = 0
	SellResource3 = 0
	SellResource4 = 0
	SellResource5 = 0
	SetSpriteImage(SceneUI.Resource1Checkbox,ImageCheckboxBlank)
	SetSpriteImage(SceneUI.Resource2Checkbox,ImageCheckboxBlank)
	SetSpriteImage(SceneUI.Resource3Checkbox,ImageCheckboxBlank)
	SetSpriteImage(SceneUI.Resource4Checkbox,ImageCheckboxBlank)
	SetSpriteImage(SceneUI.Resource5Checkbox,ImageCheckboxBlank)
endfunction

//Show the Time to Run minigame
function ShowTimeToRun()
	HideElements()
	
	ClearSpriteAnimationFrames(ViewRunning)
	AddSpriteAnimationFrame(ViewRunning,ImageRunning[1])
	AddSpriteAnimationFrame(ViewRunning,ImageRunning[2])
	AddSpriteAnimationFrame(ViewRunning,ImageRunning[3])
	AddSpriteAnimationFrame(ViewRunning,ImageRunning[4])
	AddSpriteAnimationFrame(ViewRunning,ImageRunning[5])
	AddSpriteAnimationFrame(ViewRunning,ImageRunning[6])
	AddSpriteAnimationFrame(ViewRunning,ImageRunning[7])
	AddSpriteAnimationFrame(ViewRunning,ImageRunning[8])
	AddSpriteAnimationFrame(ViewRunning,ImageRunning[9])
	AddSpriteAnimationFrame(ViewRunning,ImageRunning[10])
	//SetSpriteAnimation(ViewRunning,1136,640,10)
	PlaySprite(ViewRunning,8,1,1,10)
	SetSpriteVisible(ViewItsTheCops,1)
	SetSpriteVisible(ViewRunningBackground,1)
	SetSpriteVisible(ViewRunningBackgroundBlank,1)
	SetSpritePosition(ViewRunningBackgroundBlank,ViewLeft,ViewTop)
	//SetSpritePosition(ViewRunningBackground,ViewLeft,ViewTop)
	SetSpriteVisible(ViewRunning,1)
	SetSpritePosition(ViewRunning,ViewLeft,ViewTop)
	SetSpriteDepth(ViewRunningBackgroundBlank,6)
	SetSpriteDepth(ViewRunningBackground,5)
	SetSpriteDepth(ViewRunning,4)
	SetSpriteDepth(ViewItsTheCops,1)
	SetSpriteSize(ViewRunningBackground,1136,640)
	SetSpriteSize(ViewRunningBackgroundBlank,1136,640)
	SetSpriteSize(ViewRunning,1136,640)
	SetSpriteVisible(CopsUILeftButton,1)
	SetSpriteVisible(CopsUIRightButton,1)
	SetSpritePosition(CopsUILeftButton,ViewLeft + 50, ViewTop + 500)
	SetSpritePosition(CopsUIRightButton,ViewLeft + 950, ViewTop + 500)
	SetSpriteDepth(CopsUILeftButton,1)
	SetSpriteDepth(CopsUIRightButton,1)
	SetSpriteImage(CopsUILeftButton,ImageLeftInactive)
	SetSpriteImage(CopsUIRightButton,ImageRightInactive)

	
	TicksPassed = 1
	DistanceDirection = 0
	SpawnTick = 1
	NextSpawnTick = 0
	CurrentTap = 1
	if RunMode = 1
		SetSpriteImage(CopsUILeftButton,ImageLeftActive)
	endif
	
	SetSpritePosition(ViewRunningBackground,ViewLeft, ViewTop)
	CurrentDistance =  (Location[Player.CurrentLocation].CurrentHeat * 1136) / 100
	DistanceDirection = 1
	SetSpriteSize(ViewRunningBackground, CurrentDistance, 640)
endfunction

//Show the It's the Cops Starting Animation
function ShowItsTheCops()
	HideElements()
	StopAllMusic()
	PlayMusicOGG(MusicChase,1)
	GameState = GameStateItsTheCops
	CopsWidth = 284
	CopsHeight = 160
	CopsAngle = 0
	LastSpin = 0
	//SetSpriteAnimation(ViewItsTheCops,1136,640,2)
	//PlaySprite(ViewItsTheCops,4,1,1,2)
	SetSpriteSize(ViewItsTheCops,CopsWidth,CopsHeight)
	SetSpriteVisible(ViewItsTheCops,1)
	SetSpriteDepth(ViewItsTheCops,0)
	SetSpritePosition(ViewItsTheCops,(1136 / 2) - CopsWidth / 2 , (640 / 2) - CopsHeight / 2)
	
endfunction

//Stop Running from the Cops
function StopRunning()
	HideElements()
	//Player.Energy = Player.Energy + 1
	SetSpriteVisible(ViewRunning,0)
	SetSpriteVisible(ViewRunningBackground,0)
	SetSpriteVisible(ViewRunningBackgroundBlank,0)
	SetSpriteVisible(CopsUILeftButton,0)
	SetSpriteVisible(CopsUIRightButton,0)
	ViewLeft = LastViewLeft
	ViewTop = LastViewTop
	SetViewOffset(ViewLeft,ViewTop)
	GotAwayAlpha = 255
	SetSpriteVisible(ViewGotAway,1)
	SetSpritePosition(ViewGotAway, ViewLeft  + (1136/ 2) - (GetSpriteWidth(ViewGotAway) / 2), ViewTop + (640 / 2) - (GetSpriteHeight(ViewGotAway) / 2))
	SetSpriteColor(ViewGotAway,255,255,255,GotAwayAlpha)
	SetSpriteDepth(ViewGotAway,0)

	ShowMap()
endfunction

//Handle Input
function CheckInput()
	
	//Reset Clicked Flag
	Clicked = 0
	
	//Are we at the Busted Window?
	if GameState = GameStateBusted
		pX = GetPointerX()
		pY = GetPointerY()
		pX = pX + ViewLeft
		pY = pY + ViewTop
		
		if GetPointerReleased() = 1
			if pX > Button[ButtonBustedContinue].X and pX < Button[ButtonBustedContinue].X + GetSpriteWidth(Button[ButtonBustedContinue].Sprite)
				if pY > Button[ButtonBustedContinue].Y and pY < Button[ButtonBustedContinue].Y + GetSpriteHeight(Button[ButtonBustedContinue].Sprite)
					if GameOver = 0
						GameState = GameStateInScene
						ShowHome()
						exitfunction
					endif
					if GameOver = 1
						MainMenu()
						exitfunction
					endif
				endif
			endif
		endif
		
	endif
	
	//Are we at the Messages Window?
	if GameState = GameStateMessage
		pX = GetPointerX()
		pY = GetPointerY()
		pX = pX + ViewLeft
		pY = pY + ViewTop
		
		//SetSpriteColor(Button[ButtonAcceptObjective].Sprite,58,41,97,255)
		SetSpriteColor(Button[ButtonAcceptObjective].Sprite,200,200,200,255)
		
		if pX > Button[ButtonAcceptObjective].X and pX < Button[ButtonAcceptObjective].X + GetSpriteWidth(Button[ButtonAcceptObjective].Sprite)
			if pY > Button[ButtonAcceptObjective].Y and pY < Button[ButtonAcceptObjective].Y + GetSpriteHeight(Button[ButtonAcceptObjective].Sprite)
				SetSpriteColor(Button[ButtonAcceptObjective].Sprite,255,255,255,255)
			endif
		endif
		
		if GetPointerReleased() = 1
			if pX > Button[ButtonAcceptObjective].X and pX < Button[ButtonAcceptObjective].X + GetSpriteWidth(Button[ButtonAcceptObjective].Sprite)
				if pY > Button[ButtonAcceptObjective].Y and pY < Button[ButtonAcceptObjective].Y + GetSpriteHeight(Button[ButtonAcceptObjective].Sprite)
					if CurrentMessageEntryCounter =  CurrentMessageEntries
						//If we are showing the startup Message for a new Game
						if CurrentMessageID = 1
							Player.CurrentMessage = 2
							//After they've read the startup dialogue, we want to ONLY show the messages button.
							GameState = GameStateInScene
							ShowHome()
							SetSpriteVisible(Location[1].AirportSprite,0)
							SetTextVisible(Location[1].AirportLabel,0)
							LastWindow = GameStateInScene
							exitfunction
						endif
						//Show the Very First Voice Mail Message
						if CurrentMessageID = 2
							Player.CurrentMessage = 3
							GameState = GameStateInScene
							ShowHome()
							LastWindow = GameStateInScene
							exitfunction
						endif
						
						GameState = GameStateInScene
						ShowHome()
						LastWindow = GameStateInScene
					endif
					if CurrentMessageEntryCounter < CurrentMessageEntries
						UpdateMessage()
					endif
				endif
			endif
			SetSpriteColor(Button[ButtonAcceptObjective].Sprite,200,200,200,255)
		endif
	endif
	
	//Are we running from the Cops?
	if GameState = GameStateRunAway
		pX = GetPointerX()
		pY = GetPointerY()
		pX = pX + ViewLeft
		pY = pY + ViewTop
		
		if RunMode = 0
			//KEYBOARD CONTROLS!
			if GetRawKeyPressed(37) = 1
				//Let's loop through all the falling items! see if they're clicking the button when the falling item is att he right spot! OooOO
				
				for i = 1 to 100
					if FallingItem[i].Active = 1 
						if FallingItem[i].X = ViewLeft + 50
							if FallingItem[i].Y => ViewTop + 470 and FallingItem[i].Y <= ViewTop + 550
								SetSpriteImage(FallingItem[i].Sprite,ImageLeftActive)
								if TicksPassed >= 0 and TicksPassed < 200
									Difference = 100
								endif
								if TicksPassed >= 200 and TicksPassed < 400
									Difference = 150
								endif
								if TicksPassed >= 400 and TicksPassed < 600
									Difference = 200
								endif
								CurrentDistance = CurrentDistance - Difference
								SetSpriteSize(ViewRunningBackground,CurrentDistance,640)
							endif
						endif
					endif
				next i
				
			endif
			if GetRawKeyPressed(39) = 1
				//Let's loop through all the falling items! see if they're clicking the button when the falling item is att he right spot! OooOO
				for i = 1 to 100
					if FallingItem[i].Active = 1 
						if FallingItem[i].X = ViewLeft + 950
							if FallingItem[i].Y => ViewTop + 470 and FallingItem[i].Y <= ViewTop + 550
								SetSpriteImage(FallingItem[i].Sprite,ImageRightActive)
								if TicksPassed >= 0 and TicksPassed < 200
									Difference = 100
								endif
								if TicksPassed >= 200 and TicksPassed < 400
									Difference = 150
								endif
								if TicksPassed >= 400 and TicksPassed < 600
									Difference = 200
								endif
								CurrentDistance = CurrentDistance - Difference
								SetSpriteSize(ViewRunningBackground,CurrentDistance,640)
							endif
						endif
					endif
				next i
				
			endif
		endif
		
		if RunMode = 1
			if GetRawKeyPressed(37) = 1
				if CurrentTap = 1
					CurrentTap = 2
					MoveDistance = 10
					CurrentDistance = CurrentDistance - MoveDistance
					SetSpriteImage(CopsUIRightButton,ImageRightActive)
					SetSpriteImage(CopsUILeftButton,ImageLeftInactive)
					SetSpriteSize(ViewRunningBackground,CurrentDistance,640)
					if CurrentDistance <= 0
						StopRunning()
					endif
					
					exitfunction
				endif
				if CurrentTap = 2
					MoveDistance = 10
					CurrentDistance = CurrentDistance + MoveDistance
					SetSpriteSize(ViewRunningBackground,CurrentDistance,640)
					PlaySound(SoundFart)
					exitfunction
				endif
			endif
			if GetRawKeyPressed(39)
				if CurrentTap = 2
					CurrentTap = 1
					MoveDistance = 10
					CurrentDistance = CurrentDistance - MoveDistance
					SetSpriteImage(CopsUILeftButton,ImageLeftActive)
					SetSpriteImage(CopsUIRightButton,ImageRightInactive)
					SetSpriteSize(ViewRunningBackground,CurrentDistance,640)
					if CurrentDistance <= 0
						StopRunning()
					endif
					exitfunction
				endif
				if CurrentTap = 1
					MoveDistance = 10
					CurrentDistance = CurrentDistance + MoveDistance
					SetSpriteSize(ViewRunningBackground,CurrentDistance,640)
					PlaySound(SoundFart)
					exitfunction
				endif
			endif
			
		endif
		
		
		//TAP CONTROLS!
	endif
	
	//If we are at the buying scene?
	if GameState = GameStateBuyScene
		Clicked = 0
		Slider1Offset = GetSpriteX(SceneUI.Slider1) - GetSpriteX(SceneUI.Slider1Background) + (GetSpriteWidth(SceneUI.Slider1) / 2)
		Slider2Offset = GetSpriteX(SceneUI.Slider2) - GetSpriteX(SceneUI.Slider2Background) + (GetSpriteWidth(SceneUI.Slider2) / 2)
		Slider3Offset = GetSpriteX(SceneUI.Slider3) - GetSpriteX(SceneUI.Slider3Background) + (GetSpriteWidth(SceneUI.Slider3) / 2)
		AvailablePack = Player.MaxItems - Player.MinItems
		BuyAmount1 = Slider1Offset / GetSpriteWidth(SceneUI.Slider1Background) * AvailablePack	
		BuyAmount2 = Slider2Offset / GetSpriteWidth(SceneUI.Slider2Background) * AvailablePack	
		BuyAmount3 = Slider3Offset / GetSpriteWidth(SceneUI.Slider3Background) * AvailablePack			
		BuyPack = AvailablePack - BuyAmount1 - BuyAmount2 - BuyAmount3

		pX = GetPointerX()
		pY = GetPointerY()
		pX = pX + ViewLeft
		pY = pY + ViewTop
		
	
				
		SetSpriteColor(SceneUI.BounceButton,200,200,200,255)
		SetSpriteColor(SceneUI.BuyButton,210,210,210,255)
		
		if pX > GetSpriteX(SceneUI.BuyButton) and pX < GetSpriteX(SceneUI.BuyButton) + GetSpriteWidth(SceneUI.BuyButton)
			if pY > GetSpriteY(SceneUI.BuyButton) and pY < GetSpriteY(SceneUI.BuyButton) + GetSpriteHeight(SceneUI.BuyButton)
				SetSpriteColor(SceneUI.BuyButton,255,255,255,255)
			endif
		endif
		if pX > GetSpriteX(SceneUI.BounceButton) and pX < GetSpriteX(SceneUI.BounceButton) + GetSpriteWidth(SceneUI.BounceButton)
			if pY > GetSpriteY(SceneUI.BounceButton) and pY < GetSpriteY(SceneUI.BounceButton) + GetSpriteHeight(SceneUI.BounceButton)
				SetSpriteColor(SceneUI.BounceButton,255,255,255,255)
			endif
		endif
		
		SetSpriteColorAlpha(SceneUI.BuyButton,255)
		
		if BuyAmount1 = 0 and BuyAmount2 = 0 and BuyAmount3 = 0
			SetSpriteColorAlpha(SceneUI.BuyButton,30)
		endif
		
		if GetPointerPressed() = 1
			pX = GetPointerX()
			pY = GetPointerY()
			pX = pX + ViewLeft
			pY = pY + ViewTop
			
			
			if pX > GetSpriteX(SceneUI.Slider1) and pX < GetSpriteX(SceneUI.Slider1) + GetSpriteWidth(SceneUI.Slider1)
				if pY > GetSpriteY(SceneUI.Slider1) and pY < GetSpriteY(SceneUI.Slider1) + GetSpriteHeight(SceneUI.Slider1)
					SliderDown = 1
					SliderID = 1
				endif
			endif
			if pX > GetSpriteX(SceneUI.Slider1Background) and pX < GetSpriteX(SceneUI.Slider1Background) + GetSpriteWidth(SceneUI.Slider1Background)
				if pY > GetSpriteY(SceneUI.Slider1Background) and pY < GetSpriteY(SceneUI.Slider1Background) + GetSpriteHeight(SceneUI.Slider1Background)
					SliderDown = 1
					SliderID = 1
				endif
			endif
			if pX > GetSpriteX(SceneUI.Slider2) and pX < GetSpriteX(SceneUI.Slider2) + GetSpriteWidth(SceneUI.Slider2)
				if pY > GetSpriteY(SceneUI.Slider2) and pY < GetSpriteY(SceneUI.Slider2) + GetSpriteHeight(SceneUI.Slider2)
					SliderDown = 1
					SliderID = 2
				endif
			endif
			if pX > GetSpriteX(SceneUI.Slider2Background) and pX < GetSpriteX(SceneUI.Slider2Background) + GetSpriteWidth(SceneUI.Slider2Background)
				if pY > GetSpriteY(SceneUI.Slider2Background) and pY < GetSpriteY(SceneUI.Slider2Background) + GetSpriteHeight(SceneUI.Slider2Background)
					SliderDown = 1
					SliderID = 2
				endif
			endif
			if pX > GetSpriteX(SceneUI.Slider3) and pX < GetSpriteX(SceneUI.Slider3) + GetSpriteWidth(SceneUI.Slider3)
				if pY > GetSpriteY(SceneUI.Slider3) and pY < GetSpriteY(SceneUI.Slider3) + GetSpriteHeight(SceneUI.Slider3)
					SliderDown = 1
					SliderID = 3
				endif
			endif
			if pX > GetSpriteX(SceneUI.Slider3Background) and pX < GetSpriteX(SceneUI.Slider3Background) + GetSpriteWidth(SceneUI.Slider3Background)
				if pY > GetSpriteY(SceneUI.Slider3Background) and pY < GetSpriteY(SceneUI.Slider3Background) + GetSpriteHeight(SceneUI.Slider3Background)
					SliderDown = 1
					SliderID = 3
				endif
			endif
		endif
	
			if GetPointerState() = 1
				pX = GetPointerX()
				pY = GetPointerY()
				pX = pX + ViewLeft
				pY = pY + ViewTop

				if SliderID = 1
					if pX > GetSpriteX(SceneUI.Slider1Background) and pX < GetSpriteX(SceneUI.Slider1Background) + GetSpriteWidth(SceneUI.Slider1Background)
						SetSpritePosition(SceneUI.Slider1,pX - (GetSpriteWidth(SceneUI.Slider1) / 2),GetSpriteY(SceneUI.Slider1))
					endif
					if pX < GetSpriteX(SceneUI.Slider1Background)
						SetSpritePosition(SceneUI.Slider1,GetSpriteX(SceneUI.Slider1Background) - (GetSpriteWidth(SceneUI.Slider1) / 2),GetSpriteY(SceneUI.Slider1))
					endif
					if pX > GetSpriteX(SceneUI.Slider1Background) + GetSpriteWidth(SceneUI.Slider1Background)
						SetSpritePosition(SceneUI.Slider1,GetSpriteX(SceneUI.Slider1Background) + GetSpriteWidth(SceneUI.Slider1Background) - (GetSpriteWidth(SceneUI.Slider1) / 2),GetSpriteY(SceneUI.Slider1))
					endif
		
				endif
				
				if SliderID = 2
					if pX > GetSpriteX(SceneUI.Slider2Background) and pX < GetSpriteX(SceneUI.Slider2Background) + GetSpriteWidth(SceneUI.Slider2Background)
						SetSpritePosition(SceneUI.Slider2,pX - (GetSpriteWidth(SceneUI.Slider2) / 2),GetSpriteY(SceneUI.Slider2))
						
					endif
					if pX < GetSpriteX(SceneUI.Slider2Background)
						SetSpritePosition(SceneUI.Slider2,GetSpriteX(SceneUI.Slider2Background) - (GetSpriteWidth(SceneUI.Slider2) / 2),GetSpriteY(SceneUI.Slider2))
					endif
					if pX > GetSpriteX(SceneUI.Slider2Background) + GetSpriteWidth(SceneUI.Slider2Background)
						SetSpritePosition(SceneUI.Slider2,GetSpriteX(SceneUI.Slider2Background) + GetSpriteWidth(SceneUI.Slider2Background) - (GetSpriteWidth(SceneUI.Slider2) / 2),GetSpriteY(SceneUI.Slider2))
					endif
					
				endif
				if SliderID = 3
					if pX > GetSpriteX(SceneUI.Slider3Background) and pX < GetSpriteX(SceneUI.Slider3Background) + GetSpriteWidth(SceneUI.Slider3Background)
						SetSpritePosition(SceneUI.Slider3,pX - (GetSpriteWidth(SceneUI.Slider3) / 2),GetSpriteY(SceneUI.Slider3))
					endif
					if pX < GetSpriteX(SceneUI.Slider3Background)
						SetSpritePosition(SceneUI.Slider3,GetSpriteX(SceneUI.Slider3Background) - (GetSpriteWidth(SceneUI.Slider3) / 2),GetSpriteY(SceneUI.Slider3))
					endif
					if pX > GetSpriteX(SceneUI.Slider3Background) + GetSpriteWidth(SceneUI.Slider3Background)
						SetSpritePosition(SceneUI.Slider3,GetSpriteX(SceneUI.Slider3Background) + GetSpriteWidth(SceneUI.Slider3Background) - (GetSpriteWidth(SceneUI.Slider3) / 2),GetSpriteY(SceneUI.Slider3))
					endif
					
				endif
				BuyAmount1Price = BuyAmount1 * Location[Player.CurrentLocation].Sell1Price
				BuyAmount2Price = BuyAmount2 * Location[Player.CurrentLocation].Sell2Price
				BuyAmount3Price = BuyAmount3 * Location[Player.CurrentLocation].Sell3Price
				BuyAmountTotal = BuyAmount1Price + BuyAmount2Price + BuyAmount3Price
				if BuyAmountTotal <= Player.Cash
					SetTextColor(SceneUI.ProcessLabel,255,255,255,255)
				endif
				if BuyAmountTotal > Player.Cash
					SetTextColor(SceneUI.ProcessLabel,255,0,0,255)
				endif
				
				SetTextString(SceneUI.ProcessLabel,"$" + str(BuyAmountTotal))
				
				SetTextString(SceneUI.Resource1NameLabel,Location[Player.CurrentLocation].SellResource1Name + " (" + str(BuyAmount1) + "G)")
				SetTextString(SceneUI.Resource2NameLabel,Location[Player.CurrentLocation].SellResource2Name + " (" + str(BuyAmount2) + "G)")
				SetTextString(SceneUI.Resource3NameLabel,Location[Player.CurrentLocation].SellResource3Name + " (" + str(BuyAmount3) + "G)")
				
				
				
				if BuyPack => 0
					SetTextColor(SceneUI.FreeSpaceLabel,255,255,255,255)
				endif
				if BuyPack < 0
					SetTextColor(SceneUI.FreeSpaceLabel,255,0,0,255)
				endif
				SetTextString(SceneUI.FreeSpaceLabel,"Room Left: " + str(BuyPack))
			endif
			
			
		//print(SliderDown)
		//print(SliderID)
		
		if GetPointerReleased() = 1
			pX = GetPointerX()
			pY = GetPointerY()
			pX = pX + ViewLeft
			pY = pY + ViewTop
			SliderDown = 0
			SliderID = 0
			if pX > GetSpriteX(SceneUI.BounceButton) and pX < GetSpriteX(SceneUI.BounceButton) + GetSpriteWidth(SceneUI.BounceButton)
				if pY > GetSpriteY(SceneUI.BounceButton) and pY < GetSpriteY(SceneUI.BounceButton) + GetSpriteHeight(SceneUI.BounceButton)
					ViewTop = LastViewTop
					ViewLeft = LastViewLeft
					SetViewOffset(ViewLeft,ViewTop)
					PlaySound(SoundClick)
					ShowMap()
				endif
			endif
			if pX > GetSpriteX(SceneUI.BuyButton) and pX < GetSpriteX(SceneUI.BuyButton) + GetSpriteWidth(SceneUI.BuyButton)
				if pY > GetSpriteY(SceneUI.BuyButton) and pY < GetSpriteY(SceneUI.BuyButton) + GetSpriteHeight(SceneUI.BuyButton)
					//Make sure we can afford it!
					if BuyAmountTotal <= Player.Cash
						//Make sure we have room!
						if BuyPack => 0
							Player.MinItems = Player.MinItems + BuyAmount1 + BuyAmount2 + BuyAmount3
							Player.Cash = Player.Cash - BuyAmountTotal
								if Location[Player.CurrentLocation].Sell1 = 1
									Player.Resource1Amount = Player.Resource1Amount + BuyAmount1
								endif
								if Location[Player.CurrentLocation].Sell1 = 2
									Player.Resource2Amount = Player.Resource2Amount + BuyAmount1
								endif
								if Location[Player.CurrentLocation].Sell1 = 3
									Player.Resource3Amount = Player.Resource3Amount + BuyAmount1
								endif
								if Location[Player.CurrentLocation].Sell1 = 4
									Player.Resource4Amount = Player.Resource4Amount + BuyAmount1
								endif
								if Location[Player.CurrentLocation].Sell1 = 5
									Player.Resource5Amount = Player.Resource5Amount + BuyAmount1
								endif
								if Location[Player.CurrentLocation].Sell2 = 1
									Player.Resource1Amount = Player.Resource1Amount + BuyAmount2
								endif
								if Location[Player.CurrentLocation].Sell2 = 2
									Player.Resource2Amount = Player.Resource2Amount + BuyAmount2
								endif
								if Location[Player.CurrentLocation].Sell2 = 3
									Player.Resource3Amount = Player.Resource3Amount + BuyAmount2
								endif
								if Location[Player.CurrentLocation].Sell2 = 4
									Player.Resource4Amount = Player.Resource4Amount + BuyAmount2
								endif
								if Location[Player.CurrentLocation].Sell2 = 5
									Player.Resource5Amount = Player.Resource5Amount + BuyAmount2
								endif
								if Location[Player.CurrentLocation].Sell3 = 1
									Player.Resource1Amount = Player.Resource1Amount + BuyAmount3
								endif
								if Location[Player.CurrentLocation].Sell3 = 2
									Player.Resource2Amount = Player.Resource2Amount + BuyAmount3
								endif
								if Location[Player.CurrentLocation].Sell3 = 3
									Player.Resource3Amount = Player.Resource3Amount + BuyAmount3
								endif
								if Location[Player.CurrentLocation].Sell3 = 4
									Player.Resource4Amount = Player.Resource4Amount + BuyAmount3
								endif
								if Location[Player.CurrentLocation].Sell3 = 5
									Player.Resource5Amount = Player.Resource5Amount + BuyAmount3
								endif
								ViewLeft = ViewLeft - 200
								PlaySound(SoundBuy)
								Player.Energy = Player.Energy + 1
								if Player.TutorialState = 1
									Player.TutorialState = 2
								endif
								ShowScene(Player.CurrentLocation)
						
						endif
					endif
				endif
			endif
			
		endif
						
		//AvailablePack = Player.MaxItems - Player.MinItems
		//BuyPack = AvailablePack - BuyAmount1 - BuyAmount2 - BuyAmount3
		
		
	endif
	
	//If we are already selling?
	if GameState = GameStateSelling

		pX = GetPointerX()
		pY = GetPointerY()
		pX = pX + ViewLeft
		pY = pY + ViewTop
		
		
		
		SetSpriteColor(SceneUI.StopSellingButton,200,200,200,255)
		
		if pX > GetSpriteX(SceneUI.StopSellingButton) and pX < GetSpriteX(SceneUI.StopSellingButton) + GetSpriteWidth(SceneUI.StopSellingButton)
			if pY > GetSpriteY(SceneUI.StopSellingButton) and pY < GetSpriteY(SceneUI.StopSellingButton) + GetSpriteHeight(SceneUI.StopSellingButton)
				SetSpriteColor(SceneUI.StopSellingButton,255,255,255,255)
			endif
		endif
		if GetPointerReleased() = 1
			
			pX = GetPointerX()
			pY = GetPointerY()
			pX = pX + ViewLeft
			pY = pY + ViewTop
			
			if pX > GetSpriteX(SceneUI.StopSellingButton) and pX < GetSpriteX(SceneUI.StopSellingButton) + GetSpriteWidth(SceneUI.StopSellingButton)
				if pY > GetSpriteY(SceneUI.StopSellingButton) and pY < GetSpriteY(SceneUI.StopSellingButton) + GetSpriteHeight(SceneUI.StopSellingButton)
					StopSelling()
					Clicked = 1
					PlaySound(SoundClick)
				endif
			endif
		endif
		
	endif
	
	//If we are at the Selling Screen?
	if GameState = GameStateSellScene
			pX = GetPointerX()
			pY = GetPointerY()
			pX = pX + ViewLeft
			pY = pY + ViewTop
			
			SetSpriteColor(SceneUI.BounceButton,200,200,200,255)
			SetSpriteColor(SceneUI.SellButton,200,200,200,255)
			
			if pX > GetSpriteX(SceneUI.SellButton) and pX < GetSpriteX(SceneUI.SellButton) + GetSpriteWidth(SceneUI.SellButton)
				if pY > GetSpriteY(SceneUI.SellButton) and pY < GetSpriteY(SceneUI.SellButton) + GetSpriteHeight(SceneUI.SellButton)
					SetSpriteColor(SceneUI.SellButton,255,255,255,255)
				endif
			endif
			if pX > GetSpriteX(SceneUI.BounceButton) and pX < GetSpriteX(SceneUI.BounceButton) + GetSpriteWidth(SceneUI.BounceButton)
				if pY > GetSpriteY(SceneUI.BounceButton) and pY < GetSpriteY(SceneUI.BounceButton) + GetSpriteHeight(SceneUI.BounceButton)
					SetSpriteColor(SceneUI.BounceButton,255,255,255,255)
				endif
			endif
			
		if GetPointerReleased() = 1
			
			pX = GetPointerX()
			pY = GetPointerY()
			pX = pX + ViewLeft
			pY = pY + ViewTop
			
			
		
			if pX > GetSpriteX(SceneUI.BounceButton) and pX < GetSpriteX(SceneUI.BounceButton) + GetSpriteWidth(SceneUI.BounceButton)
				if pY > GetSpriteY(SceneUI.BounceButton) and pY < GetSpriteY(SceneUI.BounceButton) + GetSpriteHeight(SceneUI.BounceButton)
					if Clicked = 0
						ViewTop = LastViewTop
						ViewLeft = LastViewLeft
						SetViewOffset(ViewLeft,ViewTop)
						ShowMap()
						PlaySound(SoundClick)
					endif
				endif
			endif
			if pX > GetSpriteX(SceneUI.SellButton) and pX < GetSpriteX(SceneUI.SellButton) + GetSpriteWidth(SceneUI.SellButton)
				if pY > GetSpriteY(SceneUI.SellButton) and pY < GetSpriteY(SceneUI.SellButton) + GetSpriteHeight(SceneUI.SellButton)
					StartSelling()
					PlaySound(SoundClick)
				endif
			endif
			
			//Let's see if we are toggling Selling for Resource 1 let's make sure this resource is available to be sold here, and if so toggle the status
			if Location[Player.CurrentLocation].Resource1 > 0
				if pX > GetSpriteX(SceneUI.Resource1Checkbox) and pX < GetSpriteX(SceneUI.Resource1Checkbox) + GetSpriteWidth(SceneUI.Resource1Checkbox)
					if pY > GetSpriteY(SceneUI.Resource1Checkbox) and pY < GetSpriteY(SceneUI.Resource1Checkbox) + GetSpriteHeight(SceneUI.Resource1Checkbox)
						if SellResource1 = 0
							SellResource1 = 1
							SetSpriteImage(SceneUI.Resource1Checkbox,ImageCheckboxChecked)
							PlaySound(SoundClick)
							exitfunction
						endif
						if SellResource1 = 1
							SellResource1 = 0
							SetSpriteImage(SceneUI.Resource1Checkbox,ImageCheckboxBlank)
							PlaySound(SoundClick)
							exitfunction
						endif
						
					endif
				endif
			endif
			//Let's see if we are toggling Selling for Resource 2 let's make sure this resource is available to be sold here, and if so toggle the status
			if Location[Player.CurrentLocation].Resource2 > 0
				if pX > GetSpriteX(SceneUI.Resource2Checkbox) and pX < GetSpriteX(SceneUI.Resource2Checkbox) + GetSpriteWidth(SceneUI.Resource2Checkbox)
					if pY > GetSpriteY(SceneUI.Resource2Checkbox) and pY < GetSpriteY(SceneUI.Resource2Checkbox) + GetSpriteHeight(SceneUI.Resource2Checkbox)
						if SellResource2 = 0
							SellResource2 = 1
							SetSpriteImage(SceneUI.Resource2Checkbox,ImageCheckboxChecked)
							PlaySound(SoundClick)
							exitfunction
						endif
						if SellResource2 = 1
							SellResource2 = 0
							SetSpriteImage(SceneUI.Resource2Checkbox,ImageCheckboxBlank)
							PlaySound(SoundClick)
							exitfunction
						endif
					endif
				endif
			endif
			//Let's see if we are toggling Selling for Resource 3 let's make sure this resource is available to be sold here, and if so toggle the status
			if Location[Player.CurrentLocation].Resource3 > 0
				if pX > GetSpriteX(SceneUI.Resource3Checkbox) and pX < GetSpriteX(SceneUI.Resource3Checkbox) + GetSpriteWidth(SceneUI.Resource3Checkbox)
					if pY > GetSpriteY(SceneUI.Resource3Checkbox) and pY < GetSpriteY(SceneUI.Resource3Checkbox) + GetSpriteHeight(SceneUI.Resource3Checkbox)
						if SellResource3 = 0
							SellResource3 = 1
							SetSpriteImage(SceneUI.Resource3Checkbox,ImageCheckboxChecked)
							PlaySound(SoundClick)
							exitfunction
						endif
						if SellResource3 = 1
							SellResource3 = 0
							SetSpriteImage(SceneUI.Resource3Checkbox,ImageCheckboxBlank)
							PlaySound(SoundClick)
							exitfunction
						endif
					endif
				endif
			endif
			//Let's see if we are toggling Selling for Resource 4 let's make sure this resource is available to be sold here, and if so toggle the status
			if Location[Player.CurrentLocation].Resource4 > 0
				if pX > GetSpriteX(SceneUI.Resource4Checkbox) and pX < GetSpriteX(SceneUI.Resource4Checkbox) + GetSpriteWidth(SceneUI.Resource4Checkbox)
					if pY > GetSpriteY(SceneUI.Resource4Checkbox) and pY < GetSpriteY(SceneUI.Resource4Checkbox) + GetSpriteHeight(SceneUI.Resource4Checkbox)
						if SellResource4 = 0
							SellResource4 = 1
							SetSpriteImage(SceneUI.Resource4Checkbox,ImageCheckboxChecked)
							PlaySound(SoundClick)
							exitfunction
						endif
						if SellResource4 = 1
							SellResource4 = 0
							SetSpriteImage(SceneUI.Resource4Checkbox,ImageCheckboxBlank)
							PlaySound(SoundClick)
							exitfunction
						endif
					endif
				endif
			endif
			//Let's see if we are toggling Selling for Resource 5 let's make sure this resource is available to be sold here, and if so toggle the status
			if Location[Player.CurrentLocation].Resource5 > 0
				if pX > GetSpriteX(SceneUI.Resource5Checkbox) and pX < GetSpriteX(SceneUI.Resource5Checkbox) + GetSpriteWidth(SceneUI.Resource5Checkbox)
					if pY > GetSpriteY(SceneUI.Resource5Checkbox) and pY < GetSpriteY(SceneUI.Resource5Checkbox) + GetSpriteHeight(SceneUI.Resource5Checkbox)
						if SellResource5 = 0
							SellResource5 = 1
							SetSpriteImage(SceneUI.Resource5Checkbox,ImageCheckboxChecked)
							PlaySound(SoundClick)
							exitfunction
						endif
						if SellResource5 = 1
							SellResource5 = 0
							SetSpriteImage(SceneUI.Resource5Checkbox,ImageCheckboxBlank)
							PlaySound(SoundClick)
							exitfunction
						endif
					endif
				endif
			endif
		endif
		Clicked = 0
	endif
	
	//See if we are at the main menu!
	if GameState = GameStateMainMenu
		
		pX = GetPointerX()
		pY = GetPointerY()
		pX = pX + ViewLeft
		pY = pY + ViewTop
	
		SetSpriteColor(Button[ButtonNewGame].Sprite,220,220,220,255)
		SetSpriteColor(Button[ButtonCredits].Sprite,220,220,220,255)
		SetSpriteColor(Button[ButtonContinue].Sprite,220,220,220,255)
		
		if pX > Button[ButtonNewGame].X and pX < Button[ButtonNewGame].X + Button[ButtonNewGame].Width
			if pY > Button[ButtonNewGame].Y and pY < Button[ButtonNewGame].Y + Button[ButtonNewGame].Height
				SetSpriteColor(Button[ButtonNewGame].Sprite,255,255,255,255)
			endif
		endif
		if pX > Button[ButtonCredits].X and pX < Button[ButtonCredits].X + Button[ButtonCredits].Width
			if pY > Button[ButtonCredits].Y and pY < Button[ButtonCredits].Y + Button[ButtonCredits].Height
				SetSpriteColor(Button[ButtonCredits].Sprite,255,255,255,255)
			endif
		endif
		if pX > Button[ButtonContinue].X and pX < Button[ButtonContinue].X + Button[ButtonContinue].Width
			if pY > Button[ButtonContinue].Y and pY < Button[ButtonContinue].Y + Button[ButtonContinue].Height
				SetSpriteColor(Button[ButtonContinue].Sprite,255,255,255,255)
			endif
		endif
			
		//Mouse or Tap Released
		if GetPointerReleased() = 1
			
			pX = GetPointerX()
			pY = GetPointerY()
		
			if pX > Button[ButtonNewGame].X and pX < Button[ButtonNewGame].X + Button[ButtonNewGame].Width
				if pY > Button[ButtonNewGame].Y and pY < Button[ButtonNewGame].Y + Button[ButtonNewGame].Height
						NewGame()
						PlaySound(SoundClick)
						exitfunction
				endif
			endif
			
			if pX > Button[ButtonContinue].X and pX < Button[ButtonContinue].X + Button[ButtonContinue].Width
				if pY > Button[ButtonContinue].Y and pY < Button[ButtonContinue].Y + Button[ButtonContinue].Height
						LoadGame()
						PlaySound(SoundClick)
						exitfunction
				endif
			endif
		endif
		
	endif
	
	//See if we are on the Objective Window!
	if GameState = GameStateObjective
		if GetPointerReleased() = 1
			
			pX = GetPointerX()
			pY = GetPointerY()
			pX = pX + ViewLeft
			pY = pY + ViewTop
			//Cancel the Objective Window
			if pX > Button[ButtonAcceptObjective].X and pX < Button[ButtonAcceptObjective].X + Button[ButtonAcceptObjective].Width
				if pY > Button[ButtonAcceptObjective].Y and pY < Button[ButtonAcceptObjective].Y + Button[ButtonAcceptObjective].Height
					CloseObjective()
					PlaySound(SoundClick)
					exitfunction
				endif
			endif

		endif
		
	endif
	
	
	//See if we are in a scene!
	if GameState = GameStateInScene
		pX = GetPointerX()
		pY = GetPointerY()
		pX = pX + ViewLeft
		pY = pY + ViewTop
		SetSpriteVisible(ViewHoverBed,0)
		SetSpriteVisible(ViewHoverMessages,0)
		SetSpriteVisible(ViewHoverDoor,0)
		
		
		//If the player has read the introduction text AND has read the first voice mail message
		//Then allow the player to hover the mouse over the door
		if Player.CurrentMessage > 2
			if pX > Location[Player.CurrentLocation].AirportX and pX < Location[Player.CurrentLocation].AirportX + Location[Player.CurrentLocation].AirportWidth
				if pY > Location[Player.CurrentLocation].AirportY - 120 and pY < Location[Player.CurrentLocation].AirportY + Location[Player.CurrentLocation].AirportHeight + 150
					SetSpriteVisible(ViewHoverDoor,1)
					SetSpriteDepth(ViewHoverDoor,5)
					SetSpritePosition(ViewHoverDoor, ViewLeft + 764, ViewTop + 68)
					SetSpriteDepth(Location[Player.CurrentLocation].AirportSprite,1)
					SetTextDepth(Location[Player.CurrentLocation].AirportLabel,1)
				endif
			endif
			if Player.TutorialState > 1
				if pX > 411 and pX < 411 + GetSpriteWidth(ViewHoverBed)
					if pY > 444 and pY < 444 + GetSpriteHeight(ViewHoverBed)
						SetSpriteVisible(ViewHoverBed,1)
						SetSpriteDepth(ViewHoverBed,5)
						SetSpritePosition(ViewHoverBed, 411, 444)
					endif
				endif
			endif
		endif
		
		
			if pX > Button[ButtonMessages].X - 20 and pX < Button[ButtonMessages].X + 80
				if pY > Button[ButtonMessages].Y - 20 and pY < Button[ButtonMessages].Y + 100
					SetSpriteVisible(ViewHoverMessages,1)
					SetSpriteDepth(ViewHoverMessages,5)
					SetSpritePosition(ViewHoverMessages, ViewLeft + 633, ViewTop + 318)
					SetSpriteDepth(Button[ButtonMessages].Sprite,1)
					SetTextDepth(Button[ButtonMessages].Label,1)
				endif
			endif
	
		if GetPointerReleased() = 1
			
			pX = GetPointerX()
			pY = GetPointerY()
			pX = pX + ViewLeft
			pY = pY + ViewTop
			if pX > Button[ButtonMainMenu].X and pX < Button[ButtonMainMenu].X + Button[ButtonMainMenu].Width
				if pY > Button[ButtonMainMenu].Y and pY < Button[ButtonMainMenu].Y + Button[ButtonMainMenu].Height
					MainMenu()
					PlaySound(SoundClick)
					exitfunction
				endif
			endif
			
			if pX > Location[Player.CurrentLocation].AirportX and pX < Location[Player.CurrentLocation].AirportX + Location[Player.CurrentLocation].AirportWidth
				if pY > Location[Player.CurrentLocation].AirportY - 120 and pY < Location[Player.CurrentLocation].AirportY + Location[Player.CurrentLocation].AirportHeight + 150
					if Player.CurrentMessage > 2
						ShowMap()
						PlaySound(SoundClick)
						exitfunction
					endif
				endif
			endif
			
			//If they're at the Home Location
			if Player.CurrentLocation = 1
				if pX > Button[ButtonMessages].X and pX < Button[ButtonMessages].X + Button[ButtonMessages].Width
					if pY > Button[ButtonMessages].Y and pY < Button[ButtonMessages].Y + Button[ButtonMessages].Height  + 50
						ShowMessage(Player.CurrentMessage)
					endif
				endif
				if Player.TutorialState > 1
					if pX > 411 and pX < 411 + GetSpriteWidth(ViewHoverBed)
						if pY > 444 and pY < 444 + GetSpriteHeight(ViewHoverBed)
							GoToSleep()
						endif
					endif
				endif
				
			endif
			
		endif
		
	endif
	
	//If we are the View Location Options screen (GoTo or Cancel)
	if GameState = GameStateLocationOptions
		pX = GetPointerX()
		pY = GetPointerY()
		wX = ScreenToWorldX(pX)
		wY = ScreenToWorldY(pY)
		
		SetSpriteColor(Button[ButtonCancelLocation].Sprite,200,200,200,255)
		SetSpriteColor(Button[ButtonGoToLocation].Sprite,200,200,200,255)
		
		if wX > Button[ButtonCancelLocation].X and wX < Button[ButtonCancelLocation].X + Button[ButtonCancelLocation].Width
			if wY > Button[ButtonCancelLocation].Y and wY < Button[ButtonCancelLocation].Y + Button[ButtonCancelLocation].Height
				SetSpriteColor(Button[ButtonCancelLocation].Sprite,255,255,255,255)
			endif
		endif

		if wX > Button[ButtonGoToLocation].X and wX < Button[ButtonGoToLocation].X + Button[ButtonGoToLocation].Width
			if wY > Button[ButtonGoToLocation].Y and wY < Button[ButtonGoToLocation].Y + Button[ButtonGoToLocation].Height
				SetSpriteColor(Button[ButtonGoToLocation].Sprite,255,255,255,255)
			endif
		endif
					
		if GetPointerReleased() = 1
			pX = GetPointerX()
			pY = GetPointerY()
			wX = ScreenToWorldX(pX)
			wY = ScreenToWorldY(pY)
			
			//Return to Showing the Map
			if wX > Button[ButtonCancelLocation].X and wX < Button[ButtonCancelLocation].X + Button[ButtonCancelLocation].Width
				if wY > Button[ButtonCancelLocation].Y and wY < Button[ButtonCancelLocation].Y + Button[ButtonCancelLocation].Height
					ShowMap()
					PlaySound(SoundClick)
				endif
			endif
			
			//Show the Scene
			if wX > Button[ButtonGoToLocation].X and wX < Button[ButtonGoToLocation].X + Button[ButtonGoToLocation].Width
				if wY > Button[ButtonGoToLocation].Y and wY < Button[ButtonGoToLocation].Y + Button[ButtonGoToLocation].Height
					if CurrentLocation = 1
						LastViewTop = ViewTop
						LastViewLeft = ViewLeft
						//ShowScene(CurrentLocation)
						tmpLocation = CurrentLocation
						StartMoving()
						PlaySound(SoundClick)
						exitfunction
					endif
					if Player.Energy <= 0
						ShowMap()
						ShowObjective(1)
					endif
					if Player.Energy > 0
						LastViewTop = ViewTop
						LastViewLeft = ViewLeft
						//ShowScene(CurrentLocation)
						tmpLocation = CurrentLocation
						StartMoving()
						PlaySound(SoundClick)
					endif
				endif
			endif
		endif
	endif
	
	//If we are at the map Screen!
	if GameState = GameStateMap
		if GetPointerReleased() = 1
			
			pX = GetPointerX()
			pY = GetPointerY()
			wX = ScreenToWorldX(pX)
			wY = ScreenToWorldY(pY)
			
			//Are we touching a location? If so, let's show it!
			for i = 1 to NumLocations
				if wX  > Location[i].MapX and wX < Location[i].MapX + Location[i].MapWidth
					if wY  > Location[i].MapY and wY < Location[i].MapY + Location[i].MapHeight
						if DragScreenDown = 0 
							CurrentLocation = i
							ShowLocationOptions(i)	
							PlaySound(SoundClick)	
							tmpLocation = i				
							//ShowScene(i)
							exitfunction
						endif
					endif
				endif
			next i
			//Reset Drag Flag is we are not dragging the Screen
			DragScreenDown = 0
		endif
		
		if GetPointerPressed() = 1
			pX = GetPointerX()
			pY = GetPointerY()
			OriginalTouchY = pY
			OriginalTouchX = pX
			OriginalViewTop = GetViewOffsetY()
			OriginalViewLeft = GetViewOffsetX()
		endif
		
		
		//Are we dragging now?
		if GetPointerState() = 1
			pX = GetPointerX()
			pY = GetPointerY()
			
			//Are we dragging the Screen?
			//if DragScreenDown = 1
				CurrentDragY = pY
				CurrentDragX = pX
				
				Clicked = 1
				//Is the User Dragging the Screen Up?
				if CurrentDragY > OriginalTouchY
					DifferenceTouchY = CurrentDragY - OriginalTouchY
					ViewTop = OriginalViewTop - DifferenceTouchY
					DifferenceTouchY = 0
					if ViewTop <= 0
						ViewTop = 0
					Endif
					SetViewOffset(ViewLeft,ViewTop)
					SetUI()
					Clicked = 1
					DragScreenDown = 1
					
				endif
				
				//Is the User Dragging the Screen Down?
				if CurrentDragY < OriginalTouchY
					DifferenceTouchY = OriginalTouchY - CurrentDragY
					ViewTop = OriginalViewTop + DifferenceTouchY
					DifferenceTouchY = 0
					if ViewTop >= GetSpriteHeight(ViewMap) - ScreenHeight
						ViewTop = GetSpriteHeight(ViewMap) - ScreenHeight
					Endif
					SetViewOffset(ViewLeft,ViewTop)
					SetUI()
					Clicked = 1
					DragScreenDown = 1
					
				endif
				
				//Is the User Dragging the Screen Left?
				if CurrentDragX > OriginalTouchX
					DifferenceTouchX = CurrentDragX - OriginalTouchX
					ViewLeft = OriginalViewLeft - DifferenceTouchX
					DifferenceTouchX = 0
					if ViewLeft <= 0
						ViewLeft = 0
					endif
					SetViewOffset(ViewLeft, ViewTop)
					SetUI()
					Clicked =  1
					DragScreenDown = 1
					
				endif
				
				//Is the User Dragging the Screen Right?
				if CurrentDragX < OriginalTouchX
					DifferenceTouchX = OriginalTouchX - CurrentDragX
					ViewLeft = OriginalViewLeft + DifferenceTouchX
					DifferenceTouchX = 0
					if ViewLeft > GetSpriteWidth(ViewMap) - ScreenWidth
						ViewLeft = GetSpriteWidth(ViewMap) - ScreenWidth
					endif
					SetViewOffset(ViewLeft, ViewTop)
					SetUI()
					DragScreenDown = 1
				endif
			
		endif
		
	
	endif
	
	
	
endfunction

//Show Scene
function ShowScene(ID as Integer)
	
	
	//If we are at a Buy Location!
	if Location[CurrentLocation].LocationType = LocationTypeBuy
		StopAllMusic()
		if GetMusicPlayingOGG(MusicLocation) = 0
			PlayMusicOGG(MusicLocation,1)
		endif
		HideElements()
		Player.Energy = Player.Energy - 1
		Player.CurrentLocation = ID
		AvailablePack = Player.MaxItems// - Player.MinItems
		ScrollBarDown = 0
		ScrollBarID = 0
		Buy1Amount = 0
		BuyAmount1 = 0
		BuyAmount2 = 0
		BuyAmount3 = 0
		BuyResource1 = 0
		BuyResource2 = 0
		BuyResource3 = 0
		BuyResource4 = 0
		BuyResource5 = 0
		SetSpriteVisible(SceneUI.Background,1)
		tmpImage = LoadImage(Location[Player.CurrentLocation].Texture)
		SetSpriteImage(SceneUI.Background,tmpImage)
		
		SetSpriteVisible(SceneUI.Slider1Background,1)
		SetSpriteVisible(SceneUI.Slider2Background,1)
		SetSpriteVisible(SceneUI.Slider3Background,1)

		SetSpriteVisible(SceneUI.Slider1,1)
		SetSpriteVisible(SceneUI.Slider2,1)
		SetSpriteVisible(SceneUI.Slider3,1)

		
		//Set the GameState that we are in a Sell Scene
		//GameState = GameStateBuyScene
		ViewLeft = ViewLeft + 200
		SetViewOffset(ViewLeft,ViewTop)
		CurrentBuyTotal = 0
		//Here we determine if we should show the Sell or Buy Window
		SetSpriteVisible(ViewMap,1)
		SetSpriteVisible(ViewBackgroundScene,1)
		SetSpriteVisible(Location[CurrentLocation].MapSprite,1)
		SetSpritePosition(ViewBackgroundScene,ViewLeft + 660, ViewTop + 30)
		SceneUI.LocationTypeAlpha = 255
		SetTextString(SceneUI.LocationNameLabel,Location[CurrentLocation].Name)
		SetTextString(SceneUI.LocationTypeLabel,"Dealer")
		SetTextColor(SceneUI.LocationTypeLabel,255,87,126,255)
		SetTextString(SceneUI.LocationActionLabel," ")
		SetTextVisible(SceneUI.LocationNameLabel,1)
		SetTextVisible(SceneUI.LocationTypeLabel,1)
		SetTextVisible(SceneUI.LocationActionLabel,1)
		SetTextVisible(SceneUI.ResourceNameLabel,1)
		SetTextVisible(SceneUI.ResourcePriceLabel,1)
		SetTextVisible(SceneUI.Resource1NameLabel,1)
		SetTextVisible(SceneUI.Resource1PriceLabel,1)
		SetTextVisible(SceneUI.Resource2NameLabel,1)
		SetTextVisible(SceneUI.Resource2PriceLabel,1)
		SetTextVisible(SceneUI.Resource3NameLabel,1)
		SetTextVisible(SceneUI.Resource3PriceLabel,1)
		SetTextVisible(SceneUI.FreeSpaceLabel,1)
		SetTextVisible(SceneUI.BuyingSpaceLabel,1)
		SetTextVisible(SceneUI.PackLabel,1)
		SetTextVisible(SceneUI.ProcessLabel,1)
		SetTextVisible(SceneUI.ProcessTitleLabel,1)
		SetTextVisible(SceneUI.PlayerCashLabel,1)
		SetTextVisible(SceneUI.MoneyLabel,1)
		SetSpriteVisible(SceneUI.BuyButton,1)
		SetSpriteVisible(SceneUI.BounceButton,1)
		SetSpriteVisible(SceneUI.StopSellingButton,0)
		
		//Set Element Positions
		SetTextString(SceneUI.ResourceNameLabel,"Drug")
		SetTextPosition(SceneUI.LocationNameLabel,ViewLeft + 60, ViewTop + 40)
		SetTextPosition(SceneUI.LocationTypeLabel,ViewLeft + 60, ViewTop + 80)
		SetTextPosition(SceneUI.LocationActionLabel,ViewLeft + 60, ViewTop + 100)
		SetTextPosition(SceneUI.ResourceNameLabel,ViewLeft + 680, ViewTop + 55)
		SetTextPosition(SceneUI.ResourcePriceLabel,ViewLeft + 1060, ViewTop + 55)
		SetTextPosition(SceneUI.Resource1NameLabel,ViewLeft + 700, ViewTop + 100)
		SetTextPosition(SceneUI.Resource1PriceLabel,ViewLeft + 1060, ViewTop + 100)
		SetTextPosition(SceneUI.Resource2NameLabel,ViewLeft + 700, ViewTop + 180)
		SetTextPosition(SceneUI.Resource2PriceLabel,ViewLeft + 1060, ViewTop + 180)
		SetTextPosition(SceneUI.Resource3NameLabel,ViewLeft + 700, ViewTop + 260)
		SetTextPosition(SceneUI.Resource3PriceLabel,ViewLeft + 1060, ViewTop + 260)
		SetTextPosition(SceneUI.ProcessTitleLabel,ViewLeft + 680, ViewTop + 400)
		SetTextPosition(SceneUI.ProcessLabel,ViewLeft + 1060, ViewTop + 400)
		SetTextPosition(SceneUI.HeatLabel, ViewLeft + 100, ViewTop + 450)
		SetTextPosition(SceneUI.MoneyLabel, ViewLeft + 640, ViewTop + 40)
		SetTextPosition(SceneUI.PlayerCashLabel,ViewLeft + 640, ViewTop + 60)
		SetTextPosition(SceneUI.PackLabel, ViewLeft + 600, ViewTop + 570)
		SetSpritePosition(SceneUI.BuyButton,ViewLeft + 920, ViewTop + 500)
		SetSpritePosition(SceneUI.BounceButton,ViewLeft + 690, ViewTop + 500)
		SetTextString(SceneUI.ProcessTitleLabel,"Cost:")
		SetTextColor(SceneUI.PlayerCashLabel,58,244,196,255)
		
		SetTextPosition(SceneUI.FreeSpaceLabel,ViewLeft + 700, ViewTop + 350)
		
		SetSpritePosition(SceneUI.Slider1Background, ViewLeft + 700, ViewTop + 135)
		SetSpritePosition(SceneUI.Slider1, ViewLeft + 700 - (GetSpriteWidth(SceneUI.Slider1) / 2), ViewTop + 135)
		
		SetSpritePosition(SceneUI.Slider2Background, ViewLeft + 700, ViewTop + 215)
		SetSpritePosition(SceneUI.Slider2, ViewLeft + 700 - (GetSpriteWidth(SceneUI.Slider1) / 2), ViewTop + 215)
		
		SetSpritePosition(SceneUI.Slider3Background, ViewLeft + 700, ViewTop + 300)
		SetSpritePosition(SceneUI.Slider3, ViewLeft + 700 - (GetSpriteWidth(SceneUI.Slider1) / 2), ViewTop + 300)
		
	
		//Reset Today's Labels!
		SetTextString(SceneUI.Resource1NameLabel,"Not Available Today")
		SetTextColor(SceneUI.Resource1NameLabel,255,0,0,255)
		SetTextString(SceneUI.Resource1PriceLabel,"$0")
		SetTextString(SceneUI.Resource2NameLabel,"Not Available Today")
		SetTextColor(SceneUI.Resource2NameLabel,255,0,0,255)
		SetTextString(SceneUI.Resource2PriceLabel,"$0")
		SetTextString(SceneUI.Resource3NameLabel,"Not Available Today")
		SetTextColor(SceneUI.Resource3NameLabel,255,0,0,255)
		SetTextString(SceneUI.Resource3PriceLabel,"$0")
		
		
		SetSpriteColor(SceneUI.BounceButton,255,255,255,255)
		SetSpriteColor(SceneUI.SellButton,255,255,255,255)
		
		//Show the Labels Sell 1
		if Location[Player.CurrentLocation].Sell1 = 1
			Location[Player.CurrentLocation].SellResource1Name = Resource[1]
			SetTextString(SceneUI.Resource1NameLabel,Resource[1] + " (0)")
			SetTextColor(SceneUI.Resource1NameLabel,255,255,255,255)
			SetTextString(SceneUI.Resource1PriceLabel,"$" + str(Location[Player.CurrentLocation].Sell1Price) + " /g")
		endif
		if Location[Player.CurrentLocation].Sell1 = 2
			Location[Player.CurrentLocation].SellResource1Name = Resource[2]
			SetTextString(SceneUI.Resource1NameLabel,Resource[2] + " (0)")
			SetTextColor(SceneUI.Resource1NameLabel,255,255,255,255)
			SetTextString(SceneUI.Resource1PriceLabel,"$" + str(Location[Player.CurrentLocation].Sell1Price) + " /g")
		endif
		if Location[Player.CurrentLocation].Sell1 = 3
			Location[Player.CurrentLocation].SellResource1Name = Resource[3]
			SetTextString(SceneUI.Resource1NameLabel,Resource[3] + " (0)")
			SetTextColor(SceneUI.Resource1NameLabel,255,255,255,255)
			SetTextString(SceneUI.Resource1PriceLabel,"$" + str(Location[Player.CurrentLocation].Sell1Price) + " /g")
		endif
		if Location[Player.CurrentLocation].Sell1 = 4
			Location[Player.CurrentLocation].SellResource1Name = Resource[4]
			SetTextString(SceneUI.Resource1NameLabel,Resource[4] + " (0)")
			SetTextColor(SceneUI.Resource1NameLabel,255,255,255,255)
			SetTextString(SceneUI.Resource1PriceLabel,"$" + str(Location[Player.CurrentLocation].Sell1Price) + " /g")
		endif
		if Location[Player.CurrentLocation].Sell1 = 5
			Location[Player.CurrentLocation].SellResource1Name = Resource[5]
			SetTextString(SceneUI.Resource1NameLabel,Resource[5] + " (0)")
			SetTextColor(SceneUI.Resource1NameLabel,255,255,255,255)
			SetTextString(SceneUI.Resource1PriceLabel,"$" + str(Location[Player.CurrentLocation].Sell1Price) + " /g")
		endif
		
		//Show the Labels for Sell 2
		if Location[Player.CurrentLocation].Sell2 = 1
			Location[Player.CurrentLocation].SellResource2Name = Resource[1]
			SetTextString(SceneUI.Resource2NameLabel,Resource[1] + " (0)")
			SetTextColor(SceneUI.Resource2NameLabel,255,255,255,255)
			SetTextString(SceneUI.Resource2PriceLabel,"$" + str(Location[Player.CurrentLocation].Sell2Price) + " /g")
		endif
		if Location[Player.CurrentLocation].Sell2 = 2
			Location[Player.CurrentLocation].SellResource2Name = Resource[2]
			SetTextString(SceneUI.Resource2NameLabel,Resource[2] + " (0)")
			SetTextColor(SceneUI.Resource2NameLabel,255,255,255,255)
			SetTextString(SceneUI.Resource2PriceLabel,"$" + str(Location[Player.CurrentLocation].Sell2Price) + " /g")
		endif
		if Location[Player.CurrentLocation].Sell2 = 3
			Location[Player.CurrentLocation].SellResource2Name = Resource[3]
			SetTextString(SceneUI.Resource2NameLabel,Resource[3] + " (0)")
			SetTextColor(SceneUI.Resource2NameLabel,255,255,255,255)
			SetTextString(SceneUI.Resource2PriceLabel,"$" + str(Location[Player.CurrentLocation].Sell2Price) + " /g")
		endif
		if Location[Player.CurrentLocation].Sell2 = 4
			Location[Player.CurrentLocation].SellResource2Name = Resource[4]
			SetTextString(SceneUI.Resource2NameLabel,Resource[4] + " (0)")
			SetTextColor(SceneUI.Resource2NameLabel,255,255,255,255)
			SetTextString(SceneUI.Resource2PriceLabel,"$" + str(Location[Player.CurrentLocation].Sell2Price) + " /g")
		endif
		if Location[Player.CurrentLocation].Sell2 = 5
			Location[Player.CurrentLocation].SellResource2Name = Resource[5]
			SetTextString(SceneUI.Resource2NameLabel,Resource[5] + " (0)")
			SetTextColor(SceneUI.Resource2NameLabel,255,255,255,255)
			SetTextString(SceneUI.Resource2PriceLabel,"$" + str(Location[Player.CurrentLocation].Sell2Price) + " /g")
		endif
		
		//Show the Labels for Sell 3
		if Location[Player.CurrentLocation].Sell3 = 1
			Location[Player.CurrentLocation].SellResource3Name = Resource[1]
			SetTextString(SceneUI.Resource3NameLabel,Resource[1] + " (0)")
			SetTextColor(SceneUI.Resource3NameLabel,255,255,255,255)
			SetTextString(SceneUI.Resource3PriceLabel,"$" + str(Location[Player.CurrentLocation].Sell3Price) + " /g")
		endif
		if Location[Player.CurrentLocation].Sell3 = 2
			Location[Player.CurrentLocation].SellResource3Name = Resource[2]
			SetTextString(SceneUI.Resource3NameLabel,Resource[2] + " (0)")
			SetTextColor(SceneUI.Resource3NameLabel,255,255,255,255)
			SetTextString(SceneUI.Resource3PriceLabel,"$" + str(Location[Player.CurrentLocation].Sell3Price) + " /g")
		endif
		if Location[Player.CurrentLocation].Sell3 = 3
			Location[Player.CurrentLocation].SellResource3Name = Resource[3]
			SetTextString(SceneUI.Resource3NameLabel,Resource[3] + " (0)")
			SetTextColor(SceneUI.Resource3NameLabel,255,255,255,255)
			SetTextString(SceneUI.Resource3PriceLabel,"$" + str(Location[Player.CurrentLocation].Sell3Price) + " /g")
		endif
		if Location[Player.CurrentLocation].Sell3 = 4
			Location[Player.CurrentLocation].SellResource3Name = Resource[4]
			SetTextString(SceneUI.Resource3NameLabel,Resource[4] + " (0)")
			SetTextColor(SceneUI.Resource3NameLabel,255,255,255,255)
			SetTextString(SceneUI.Resource3PriceLabel,"$" + str(Location[Player.CurrentLocation].Sell3Price) + " /g")
		endif
		if Location[Player.CurrentLocation].Sell3 = 5
			Location[Player.CurrentLocation].SellResource3Name = Resource[5]
			SetTextString(SceneUI.Resource3NameLabel,Resource[5] + " (0)")
			SetTextColor(SceneUI.Resource3NameLabel,255,255,255,255)
			SetTextString(SceneUI.Resource3PriceLabel,"$" + str(Location[Player.CurrentLocation].Sell3Price) + " /g")
		endif
		
		Slider1Offset = GetSpriteX(SceneUI.Slider1) - GetSpriteX(SceneUI.Slider1Background) + (GetSpriteWidth(SceneUI.Slider1) / 2)
		Slider2Offset = GetSpriteX(SceneUI.Slider2) - GetSpriteX(SceneUI.Slider2Background) + (GetSpriteWidth(SceneUI.Slider2) / 2)
		Slider3Offset = GetSpriteX(SceneUI.Slider3) - GetSpriteX(SceneUI.Slider3Background) + (GetSpriteWidth(SceneUI.Slider3) / 2)
		AvailablePack = Player.MaxItems - Player.MinItems
		BuyAmount1 = Slider1Offset / GetSpriteWidth(SceneUI.Slider1Background) * AvailablePack	
		BuyAmount2 = Slider2Offset / GetSpriteWidth(SceneUI.Slider2Background) * AvailablePack	
		BuyAmount3 = Slider3Offset / GetSpriteWidth(SceneUI.Slider3Background) * AvailablePack			
		BuyPack = AvailablePack - BuyAmount1 - BuyAmount2 - BuyAmount3
		SetTextString(SceneUI.FreeSpaceLabel,"Room Left: " + str(BuyPack))
		SetTextString(SceneUI.PlayerCashLabel,"$" + str(Player.Cash))
		SetTextString(SceneUI.PackLabel,"Pack: " + str(Player.MinItems) + "/" + str(Player.MaxItems))
		SetSpriteDepth(SceneUI.Background,10)
		SetSpriteDepth(ViewBackgroundScene,9)
		SetTextDepth(SceneUI.LocationNameLabel,1)
		SetTextDepth(SceneUI.LocationTypeLabel,1)
		SetTextDepth(SceneUI.LocationActionLabel,1)
		SetTextDepth(SceneUI.ResourceNameLabel,1)
		SetTextDepth(SceneUI.ResourcePriceLabel,1)
		SetTextDepth(SceneUI.Resource1NameLabel,1)
		SetTextDepth(SceneUI.Resource1PriceLabel,1)
		SetTextDepth(SceneUI.Resource2NameLabel,1)
		SetTextDepth(SceneUI.Resource2PriceLabel,1)
		SetTextDepth(SceneUI.Resource3NameLabel,1)
		SetTextDepth(SceneUI.Resource3PriceLabel,1)
		SetTextDepth(SceneUI.FreeSpaceLabel,1)
		SetTextDepth(SceneUI.BuyingSpaceLabel,1)
		SetTextDepth(SceneUI.PackLabel,1)
		SetTextDepth(SceneUI.ProcessLabel,1)
		SetTextDepth(SceneUI.ProcessTitleLabel,1)
		SetTextDepth(SceneUI.PlayerCashLabel,1)
		SetTextDepth(SceneUI.BuyButton,1)
		SetTextDepth(SceneUI.BounceButton,1)
		SetTextDepth(SceneUI.StopSellingButton,1)
		SetSpritePosition(SceneUI.Background,ViewLeft,ViewTop)
		SetSpriteDepth(SceneUI.Slider1Background,1)
		SetSpriteDepth(SceneUI.Slider2Background,1)
		SetSpriteDepth(SceneUI.Slider3Background,1)
		SetSpriteDepth(SceneUI.BuyButton,1)
		SetSpriteDepth(SceneUI.SellButton,1)
		SetSpriteDepth(SceneUI.BounceButton,1)
		SetSpriteDepth(SceneUI.Slider1,1)
		SetSpriteDepth(SceneUI.Slider2,1)
		SetSpriteDepth(SceneUI.Slider3,1)
		SetSpriteVisible(Location[Player.CurrentLocation].MapSprite,0)
		if Player.TutorialState = 1
			SetSpriteVisible(ViewTutorial,1)
			SetSpritePosition(ViewTutorial, ViewLeft + 280, ViewTop + 200)
			SetTextString(LabelTutorial,"Use the sliders to buy drugs from the thugs!")
			SetTextVisible(LabelTutorial,1)
			SetTextPosition(LabelTutorial,ViewLeft + 280 + GetSpriteWidth(ViewTutorial) / 2, ViewTop + 210)
			SetSpriteDepth(ViewTutorial,1)
			SetTextDepth(LabelTutorial,1)
		endif
		if Player.TutorialState = 2
			SetSpriteVisible(ViewTutorial,1)
			SetSpritePosition(ViewTutorial, ViewLeft + 280, ViewTop + 200)
			SetTextString(LabelTutorial,"Bounce and find a spot to sell these drugs!")
			SetTextVisible(LabelTutorial,1)
			SetTextPosition(LabelTutorial,ViewLeft + 280 + GetSpriteWidth(ViewTutorial) / 2, ViewTop + 210)
			SetSpriteDepth(ViewTutorial,1)
			SetTextDepth(LabelTutorial,1)
		endif
		if Player.TutorialState = 4
			SetSpriteVisible(ViewTutorial,1)
			SetSpritePosition(ViewTutorial, ViewLeft + 280, ViewTop + 200)
			SetTextString(LabelTutorial,"Buy cheap, sell high, get rich! Don't forget to sleep!")
			SetTextVisible(LabelTutorial,1)
			SetTextPosition(LabelTutorial,ViewLeft + 280 + GetSpriteWidth(ViewTutorial) / 2, ViewTop + 210)
			SetSpriteDepth(ViewTutorial,1)
			SetTextDepth(LabelTutorial,1)
		endif
	endif
	
	//If we are at a Sell Location!
	if Location[CurrentLocation].LocationType = LocationTypeSell
		HideElements()
		StopAllMusic()
		PlayMusicOGG(MusicLocation,1)
		Player.Energy = Player.Energy - 1
		//Reset the Heat Meter
		Player.CurrentLocation = ID
		//Reset the Sale Checkboxes when we load the scene each time!
		SellResource1 = 0
		SellResource2 = 0
		SellResource3 = 0
		SellResource4 = 0
		SellResource5 = 0
		SetSpriteImage(SceneUI.Resource1Checkbox,ImageCheckboxBlank)
		SetSpriteImage(SceneUI.Resource2Checkbox,ImageCheckboxBlank)
		SetSpriteImage(SceneUI.Resource3Checkbox,ImageCheckboxBlank)
		SetSpriteImage(SceneUI.Resource4Checkbox,ImageCheckboxBlank)
		SetSpriteImage(SceneUI.Resource5Checkbox,ImageCheckboxBlank)
		
		//Set the GameState that we are in a Sell Scene
		//GameState = GameStateSellScene
		ViewLeft = ViewLeft + 200
		SetViewOffset(ViewLeft,ViewTop)
		CurrentSaleTotal = 0
		SetTextString(SceneUI.SoldLabel,"$" + str(CurrentSaleTotal))
		//Here we determine if we should show the Sell or Buy Window
		HideElements()
		SetSpriteVisible(ViewMap,1)
		SetSpriteVisible(ViewBackgroundScene,1)
		SetSpriteVisible(Location[CurrentLocation].MapSprite,1)
		SetSpritePosition(ViewBackgroundScene,ViewLeft + 660, ViewTop + 30)
		
		SceneUI.SoldLabelAlpha = 255
		SceneUI.SoldLabelDirection = 1
		SetTextVisible(SceneUI.SoldLabel,0)
		
		SceneUI.LocationTypeAlpha = 255
		SetTextString(SceneUI.ResourceNameLabel,"What to Sell")
		SetTextString(SceneUI.LocationNameLabel,Location[CurrentLocation].Name)
		SetTextString(SceneUI.LocationTypeLabel,"")
		SetTextColor(SceneUI.LocationTypeLabel,0,128,128,SceneUI.LocationTypeAlpha)
		SetTextString(SceneUI.LocationActionLabel," ")
		SetTextVisible(SceneUI.LocationNameLabel,1)
		SetTextVisible(SceneUI.LocationTypeLabel,1)
		SetTextVisible(SceneUI.LocationActionLabel,1)
		SetTextVisible(SceneUI.ResourceNameLabel,1)
		SetTextVisible(SceneUI.ResourcePriceLabel,1)
		SetTextVisible(SceneUI.Resource1NameLabel,1)
		SetTextVisible(SceneUI.Resource1PriceLabel,1)
		SetTextVisible(SceneUI.Resource2NameLabel,1)
		SetTextVisible(SceneUI.Resource2PriceLabel,1)
		SetTextVisible(SceneUI.Resource3NameLabel,1)
		SetTextVisible(SceneUI.Resource3PriceLabel,1)
		SetTextVisible(SceneUI.Resource4NameLabel,1)
		SetTextVisible(SceneUI.Resource4PriceLabel,1)
		SetTextVisible(SceneUI.Resource5NameLabel,1)
		SetTextVisible(SceneUI.Resource5PriceLabel,1)
		SetTextVisible(SceneUI.ProcessLabel,1)
		SetTextVisible(SceneUI.ProcessTitleLabel,1)
		SetTextVisible(SceneUI.HeatLabel,1)
		SetTextVisible(SceneUI.PlayerCashLabel,1)
		SetSpriteVisible(SceneUI.Resource1Checkbox,1)
		SetSpriteVisible(SceneUI.Resource2Checkbox,1)
		SetSpriteVisible(SceneUI.Resource3Checkbox,1)
		SetSpriteVisible(SceneUI.Resource4Checkbox,1)
		SetSpriteVisible(SceneUI.Resource5Checkbox,1)
		SetSpriteVisible(SceneUI.SellButton,1)
		SetSpriteVisible(SceneUI.BounceButton,1)
		SetSpriteVisible(SceneUI.HeatbarBackground,1)
		SetSpriteVisible(SceneUI.HeatbarForeground,1)
		SetSpriteVisible(SceneUI.StopSellingButton,0)
		SetSpriteVisible(SceneUI.PackLabel,1)
		
		//Set Element Positions
		SetTextPosition(SceneUI.LocationNameLabel,ViewLeft + 60, ViewTop + 40)
		SetTextPosition(SceneUI.LocationTypeLabel,ViewLeft + 60, ViewTop + 80)
		SetTextPosition(SceneUI.LocationActionLabel,ViewLeft + 60, ViewTop + 100)
		SetTextPosition(SceneUI.ResourceNameLabel,ViewLeft + 680, ViewTop + 55)
		SetTextPosition(SceneUI.ResourcePriceLabel,ViewLeft + 1060, ViewTop + 55)
		SetTextPosition(SceneUI.Resource1NameLabel,ViewLeft + 740, ViewTop + 110)
		SetTextPosition(SceneUI.Resource1PriceLabel,ViewLeft + 1060, ViewTop + 110)
		SetTextPosition(SceneUI.Resource2NameLabel,ViewLeft + 740, ViewTop + 160)
		SetTextPosition(SceneUI.Resource2PriceLabel,ViewLeft + 1060, ViewTop + 160)
		SetTextPosition(SceneUI.Resource3NameLabel,ViewLeft + 740, ViewTop + 210)
		SetTextPosition(SceneUI.Resource3PriceLabel,ViewLeft + 1060, ViewTop + 210)
		SetTextPosition(SceneUI.Resource4NameLabel,ViewLeft + 740, ViewTop + 260)
		SetTextPosition(SceneUI.Resource4PriceLabel,ViewLeft + 1060, ViewTop + 260)
		SetTextPosition(SceneUI.Resource5NameLabel,ViewLeft + 740, ViewTop + 310)
		SetTextPosition(SceneUI.Resource5PriceLabel,ViewLeft + 1060, ViewTop + 310)
		SetTextPosition(SceneUI.ProcessTitleLabel,ViewLeft + 680, ViewTop + 400)
		SetTextPosition(SceneUI.ProcessLabel,ViewLeft + 1060, ViewTop + 400)
		SetTextPosition(SceneUI.HeatLabel, ViewLeft + 100, ViewTop + 450)
		SetTextVisible(SceneUI.MoneyLabel,1)
		
		SetTextPosition(SceneUI.MoneyLabel, ViewLeft + 640, ViewTop + 40)
		SetTextPosition(SceneUI.PlayerCashLabel,ViewLeft + 640, ViewTop + 60)
		SetTextColor(SceneUI.PlayerCashLabel,58,244,196,255)
		
		
		SetSpritePosition(SceneUI.Resource1Checkbox,ViewLeft + 680, ViewTop + 110)
		SetSpritePosition(SceneUI.Resource2Checkbox,ViewLeft + 680, ViewTop + 160)
		SetSpritePosition(SceneUI.Resource3Checkbox,ViewLeft + 680, ViewTop + 210)
		SetSpritePosition(SceneUI.Resource4Checkbox,ViewLeft + 680, ViewTop + 260)
		SetSpritePosition(SceneUI.Resource5Checkbox,ViewLeft + 680, ViewTop + 310)
		SetSpritePosition(SceneUI.SellButton,ViewLeft + 920, ViewTop + 500)
		SetSpritePosition(SceneUI.BounceButton,ViewLeft + 690, ViewTop + 500)
		SetSpritePosition(SceneUI.HeatbarBackground, ViewLeft + 100, ViewTop + 500)
		SetSpritePosition(SceneUI.HeatbarForeground, ViewLeft + 100, ViewTop + 500)
		SetSpritePosition(SceneUI.StopSellingButton, ViewLeft + 690, ViewTop + 500)
		//Reset the Heatbar
		//SetSpriteSize(SceneUI.HeatbarForeground,0,GetSpriteHeight(SceneUI.HeatbarForeground))
		HeatbarWidth = (Location[Player.CurrentLocation].CurrentHeat / GetSpriteWidth(SceneUI.HeatbarBackground)) / (100 / GetSpriteWidth(SceneUI.HeatbarBackground)) * GetSpriteWidth(SceneUI.HeatbarBackground)
		SetSpriteSize(SceneUI.HeatbarForeground,HeatbarWidth,GetSpriteHeight(SceneUI.HeatbarForeground))
		SetTextString(SceneUI.PlayerCashLabel,"$" + str(Player.Cash))
		//barWidth = ((MapNpc(i).Vital(Vitals.HP) / sWidth) / (Npc(npcNum).HP / sWidth)) * sWidth
		  
		  
		//Set Element Depths
		SetTextDepth(SceneUI.LocationNameLabel,1)
		SetTextDepth(SceneUI.LocationTypeLabel,1)
		SetTextDepth(SceneUI.LocationActionLabel,1)
		
		//Now that all the UI elements are set to the proper locations, let's determine what resources are available to sell here!
	
		tmpString = Resource[1] + " " + str(Player.Resource1Amount) + "G"
		SetTextString(SceneUI.Resource1NameLabel, tmpString)
	
		tmpString = Resource[2] + " " + str(Player.Resource2Amount) + "G"
		SetTextString(SceneUI.Resource2NameLabel, tmpString)
		
		tmpString = Resource[3] + " " + str(Player.Resource3Amount) + "G"
		SetTextString(SceneUI.Resource3NameLabel, tmpString)
		
		tmpString = Resource[4] + " " + str(Player.Resource4Amount) + "G"
		SetTextString(SceneUI.Resource4NameLabel, tmpString)
		
		tmpString = Resource[5] + " " + str(Player.Resource5Amount) + "G"
		SetTextString(SceneUI.Resource5NameLabel, tmpString)
		SetTextColor(SceneUI.Resource1NameLabel,255,255,255,255)
		SetTextColor(SceneUI.Resource2NameLabel,255,255,255,255)
		SetTextColor(SceneUI.Resource3NameLabel,255,255,255,255)
		SetTextColor(SceneUI.Resource4NameLabel,255,255,255,255)
		SetTextColor(SceneUI.Resource5NameLabel,255,255,255,255)
		SetSpriteColor(SceneUI.Resource1CheckBox,255,255,255,255)
		SetSpriteColor(SceneUI.Resource2CheckBox,255,255,255,255)
		SetSpriteColor(SceneUI.Resource3CheckBox,255,255,255,255)
		SetSpriteColor(SceneUI.Resource4CheckBox,255,255,255,255)
		SetSpriteColor(SceneUI.Resource5CheckBox,255,255,255,255)
		
		if Player.Resource1Amount = 0
			SetTextColor(SceneUI.Resource1NameLabel,73,55,113,255)
			SetSpriteColor(SceneUI.Resource1CheckBox,255,255,255,30)
		endif
		if Player.Resource2Amount = 0
			SetTextColor(SceneUI.Resource2NameLabel,73,55,113,255)
			SetSpriteColor(SceneUI.Resource2CheckBox,255,255,255,30)
		endif
		if Player.Resource3Amount = 0
			SetTextColor(SceneUI.Resource3NameLabel,73,55,113,255)
			SetSpriteColor(SceneUI.Resource3CheckBox,255,255,255,30)
		endif
		if Player.Resource4Amount = 0
			SetTextColor(SceneUI.Resource4NameLabel,73,55,113,255)
			SetSpriteColor(SceneUI.Resource4CheckBox,255,255,255,30)
		endif
		if Player.Resource5Amount = 0
			SetTextColor(SceneUI.Resource5NameLabel,73,55,113,255)
			SetSpriteColor(SceneUI.Resource5CheckBox,255,255,255,30)
		endif
		
		//If we can sell resource 1 here
		if Location[ID].Resource1 > 0
		//	SetTextColor(SceneUI.Resource1NameLabel,255,255,255,255)
			SetTextColor(SceneUI.Resource1PriceLabel,255,255,255,255)
			tmpString = "$" + str(Location[ID].Resource1Price) + "/g"
			SetTextString(SceneUI.Resource1PriceLabel, tmpString)
		else
			SetTextColor(SceneUI.Resource1NameLabel,255,0,0,255)
			SetTextColor(SceneUI.Resource1PriceLabel,255,0,0,255)
			tmpString = "Unavailable"
			SetTextString(SceneUI.Resource1PriceLabel, tmpString)
		endif
		
		//If we can sell resource 2 here
		if Location[ID].Resource2 > 0
		//	SetTextColor(SceneUI.Resource2NameLabel,255,255,255,255)
			SetTextColor(SceneUI.Resource2PriceLabel,255,255,255,255)
			tmpString = "$" + str(Location[ID].Resource2Price) + "/g"
			SetTextString(SceneUI.Resource2PriceLabel, tmpString)
		else
			SetTextColor(SceneUI.Resource2NameLabel,255,0,0,255)
			SetTextColor(SceneUI.Resource2PriceLabel,255,0,0,255)
			tmpString = "Unavailable"
			SetTextString(SceneUI.Resource2PriceLabel, tmpString)
		endif
		
		//if we can sell resource 3 here
		if Location[ID].Resource3 > 0
			//SetTextColor(SceneUI.Resource3NameLabel,255,255,255,255)
			SetTextColor(SceneUI.Resource3PriceLabel,255,255,255,255)
			tmpString = "$" + str(Location[ID].Resource3Price) + "/g"
			SetTextString(SceneUI.Resource3PriceLabel, tmpString)
		else
			SetTextColor(SceneUI.Resource3NameLabel,255,0,0,255)
			SetTextColor(SceneUI.Resource3PriceLabel,255,0,0,255)
			tmpString = "Unavailable"
			SetTextString(SceneUI.Resource3PriceLabel, tmpString)
		endif
		
		//if we can sell resource 4 here
		if Location[ID].Resource4 > 0
			//SetTextColor(SceneUI.Resource4NameLabel,255,255,255,255)
			SetTextColor(SceneUI.Resource4PriceLabel,255,255,255,255)
			tmpString = "$" + str(Location[ID].Resource4Price) + "/g"
			SetTextString(SceneUI.Resource4PriceLabel, tmpString)
		else
			SetTextColor(SceneUI.Resource4NameLabel,255,0,0,255)
			SetTextColor(SceneUI.Resource4PriceLabel,255,0,0,255)
			tmpString = "Unavailable"
			SetTextString(SceneUI.Resource4PriceLabel, tmpString)
		endif
		
		//if we can sell resource 5 here
		if Location[ID].Resource5 > 0
		//	SetTextColor(SceneUI.Resource5NameLabel,255,255,255,255)
			SetTextColor(SceneUI.Resource5PriceLabel,255,255,255,255)
			tmpString = "$" + str(Location[ID].Resource5Price) + "/g"
			SetTextString(SceneUI.Resource5PriceLabel, tmpString)
		else
			SetTextColor(SceneUI.Resource5NameLabel,255,0,0,255)
			SetTextColor(SceneUI.Resource5PriceLabel,255,0,0,255)
			tmpString = "Unavailable"
			SetTextString(SceneUI.Resource5PriceLabel, tmpString)
		endif
		SetSpriteVisible(SceneUI.Slider1Background,0)
		SetSpriteVisible(SceneUI.Slider2Background,0)
		SetSpriteVisible(SceneUI.Slider3Background,0)
		SetSpriteDepth(SceneUI.Resource1Checkbox,1)
		SetSpriteDepth(SceneUI.Resource2Checkbox,1)
		SetSpriteDepth(SceneUI.Resource3Checkbox,1)
		SetSpriteDepth(SceneUI.Resource4Checkbox,1)
		SetSpriteDepth(SceneUI.Resource5Checkbox,1)
		SetSpriteVisible(ViewRunning,0)
		SetTextVisible(SceneUI.PackLabel,1)
		SetTextDepth(SceneUI.PackLabel,1)
		SetTextString(SceneUI.PackLabel,"Pack: " + str(Player.MinItems) + "/" + str(Player.MaxItems))
		SetTextPosition(SceneUI.PackLabel, ViewLeft + 600, ViewTop + 570)
		SetTextString(SceneUI.ProcessTitleLabel,"Sold:")
		NewHeatbarWidth = Location[Player.CurrentLocation].CurrentHeat / GetSpriteWidth(SceneUI.HeatbarBackground) / (100 / GetSpriteWidth(SceneUI.HeatbarBackground)) * GetSpriteWidth(SceneUI.HeatbarBackground)
		OldHeatbarWidth = Location[Player.CurrentLocation].CurrentHeat / GetSpriteWidth(SceneUI.HeatbarBackground) / (100 / GetSpriteWidth(SceneUI.HeatbarBackground)) * GetSpriteWidth(SceneUI.HeatbarBackground)
		if Player.TutorialState = 3
			SetSpriteVisible(ViewTutorial,1)
			SetSpritePosition(ViewTutorial, ViewLeft + 280, ViewTop + 200)
			SetTextString(LabelTutorial,"Start selling, if you get busted, run away!")
			SetTextVisible(LabelTutorial,1)
			SetTextPosition(LabelTutorial,ViewLeft + 280 + GetSpriteWidth(ViewTutorial) / 2, ViewTop + 210)
			SetSpriteDepth(ViewTutorial,1)
			SetTextDepth(LabelTutorial,1)
		endif
		if Player.TutorialState = 4
			SetSpriteVisible(ViewTutorial,1)
			SetSpritePosition(ViewTutorial, ViewLeft + 280, ViewTop + 200)
			SetTextString(LabelTutorial,"Buy cheap, sell high, get rich! Don't forget to sleep!")
			SetTextVisible(LabelTutorial,1)
			SetTextPosition(LabelTutorial,ViewLeft + 280 + GetSpriteWidth(ViewTutorial) / 2, ViewTop + 210)
			SetSpriteDepth(ViewTutorial,1)
			SetTextDepth(LabelTutorial,1)
		endif
	endif
	SetSpriteVisible(ViewItsTheCops,0)
	LastWindow = GameStateInScene
endfunction

//Show Home
function ShowHome()
	//ViewTop = 0
	//ViewLeft = 0
	OriginalViewLeft = 0
	OriginalViewTop = 0
	OriginalTouchX = 0
	OriginalTouchY = 0
	StopAllMusic()
	if GetMusicPlayingOGG(MusicLocation) = 0
		PlayMusicOGG(MusicLocation,1)
	endif

	Player.CurrentLocation = 1
	HideElements()
	
	ID = 1
	SetSpriteVisible(Location[ID].Sprite,1)
	
	//If we can Buy/Sell here, show those buttons
	if Location[ID].BuyVisible = 1
		SetSpriteVisible(Location[ID].BuySprite,1)
	endif
	if Location[ID].SellVisible = 1
		SetSpriteVisible(Location[ID].SellSprite,1)
	endif
	
	//If you can access a clinic from here, show it!
	if Location[ID].HospitalVisible = 1
		SetSpriteVisible(Location[ID].HospitalSprite,1)
		SetTextVisible(Location[ID].HospitalLabel,1)
	endif
	
	//Set all the Buttons for the Scene
	SetSpriteVisible(Location[ID].AirportSprite,1)
	SetSpritePosition(Location[ID].BuySprite,Location[ID].BuyX,Location[ID].BuyY)
	SetSpritePosition(Location[ID].SellSprite,Location[ID].SellX,Location[ID].SellY)
	SetSpritePosition(Location[ID].HospitalSprite,Location[ID].HospitalX,Location[ID].HospitalY)
	SetSpritePosition(Location[ID].AirportSprite,Location[ID].AirportX,Location[ID].AirportY)
	SetTextVisible(Location[ID].AirportLabel,1)
	PlaySprite(Location[ID].HospitalSprite,8,1,1,4)
	PlaySprite(Location[ID].AirportSprite,8,1,1,4)
	SetTextVisible(SceneUI.MoneyLabel,1)
	SetTextPosition(SceneUI.MoneyLabel,ViewLeft + ScreenWidth - 40,ViewTop + 30)
	SetTextVisible(SceneUI.PlayerCashLabel,1)
	SetTextPosition(SceneUI.PlayerCashLabel,ViewLeft + ScreenWidth - 40, ViewTop + 60)
	if Player.CurrentMessage = 2
		SetTextString(SceneUI.PlayerCashLabel,"$0")
	endif
	if Player.CurrentMessage > 2
		SetTextString(SceneUI.PlayerCashLabel,"$" + str(Player.Cash))
	endif
	//Set the players position on the Scene
	SetSpriteVisible(Player.Sprite,1)
	SetSpriteDepth(Player.Sprite,3)
	SetSpritePosition(Player.Sprite,Location[ID].PlayerX,Location[ID].PlayerY)
	
	//If we are at Scene 1 (which is the home scene), then we want to show the Messages and News buttons!
	if ID = 1
		SetSpriteVisible(Button[ButtonMessages].Sprite,1)
		//SetSpriteVisible(Button[ButtonNews].Sprite,1)
		//SetSpriteVisible(Button[ButtonStash].Sprite,1)
		SetTextVisible(Button[ButtonMessages].Label,1)
		//SetTextVisible(Button[ButtonNews].Label,1)
		//SetTextVisible(Button[ButtonStash].Label,1)
		SetSpriteDepth(Button[ButtonMessages].Sprite,2)
		//SetSpriteDepth(Button[ButtonNews].Sprite,2)
		//SetSpriteDepth(Button[ButtonStash].Sprite,2)
		PlaySprite(Button[ButtonMessages].Sprite,8,1,1,4)
		//PlaySprite(Button[ButtonNews].Sprite,8,1,1,4)
		//PlaySprite(Button[ButtonStash].Sprite,8,1,1,4)
		if Player.TutorialState > 1
			SetSpriteVisible(Button[ButtonSleep].Sprite,1)
			SetSpritePosition(Button[ButtonSleep].Sprite, 500,400)
			SetSpriteDepth(Button[ButtonSleep].Sprite,2)
			PlaySprite(Button[ButtonSleep].Sprite,8,1,1,4)
			SetTextVisible(Button[ButtonSleep].Label,1)
			SetTextPosition(Button[ButtonSleep].Label, 535, 380)
		endif
	endif
	
	SetSpriteVisible(Button[ButtonMainMenu].Sprite,1)
	SetSpriteDepth(Button[ButtonMainMenu].Sprite,1)
endfunction

//Go to Sleep!
function GoToSleep()
	GameState = GameStateSleep
	SleepAlpha = 0
	SleepDirection = 1
	Player.Energy = 8
	SetSpriteColorAlpha(ViewBackgroundSleep,0)
	SetSpriteVisible(ViewBackgroundSleep,1)
	SetSpriteDepth(ViewBackgroundSleep,0)
	SetSpritePosition(ViewBackgroundSleep,ViewLeft,ViewTop)
	NewDay()
	SaveGame()
endfunction

//Show Map
function ShowMap()
	HideElements()
	GameState = GameStateMap
	
	//StopMusicOGG()
	StopAllMusic()
	PlayMusicOGG(MusicMap,1)
	
	SetSpriteVisible(ViewMap,1)
	SetSpriteVisible(ViewMapLogo,1)
	SetTextVisible(LabelTitleEnergy,1)
	SetTextVisible(LabelTitleMoney,1)
	SetTextVisible(LabelMoney,1)
	SetTextVisible(LabelPack,1)
	SetTextVisible(LabelTitlePack,1)
	SetTextString(LabelPack,str(Player.MinItems) + " / " + str(Player.MaxItems))
	SetTextString(LabelMoney,"$" + str(Player.Cash))
	//SetSpriteVisible(Button[ButtonCancelMap].Sprite,1)
	//SetSpriteDepth(Button[ButtonCancelMap].Sprite,3)
	SetSpriteVisible(ViewEnergyIcon,1)
	SetSpriteDepth(ViewEnergyIcon,1)
	//Loop through and show all map icons on the map for each location!
	if player.energy => 1
		for i = 1 to Player.Energy
			SetSpriteVisible(ViewEnergy[i],1)
			SetSpriteDepth(ViewEnergy[i],1)
		next i
	endif
	
	
	for i = 1 to NumLocations
		//Only show this location if they have enough cash!
		if Player.Cash => Location[i].CashNeededTobeVisible
			SetSpriteVisible(Location[i].MapSprite,1)
			SetSpriteDepth(Location[i].MapSprite,3)
			SetSpritePosition(Location[i].MapSprite,Location[i].MapX,Location[i].MapY)
			//SetTextVisible(Location[i].MapLabel,1)
			//SetTextDepth(Location[i].MapLabel,2)
		endif
		
	next i
	
	//Check if we are in the Tutorial Still
	if Player.TutorialState = 1
		for i = 1 to NumLocations
			SetSpriteVisible(Location[i].MapSprite,0)
		next i
		SetSpriteVisible(Location[1].MapSprite,1)
		SetSpriteVisible(Location[3].MapSprite,1)
	endif
	if Player.TutorialState = 2
		for i = 1 to NumLocations
			SetSpriteVisible(Location[i].MapSprite,0)
		next i
		SetSpriteVisible(Location[1].MapSprite,1)
		SetSpriteVisible(Location[2].MapSprite,1)
		SetSpriteVisible(Location[3].MapSprite,1)
	endif
	
	
	SetTextVisible(LabelDays,1)
	SetTextPosition(LabelDays, ViewLeft + ScreenWidth / 2,ViewTop + 100)
	SetTextDepth(LabelDays,1)
	
	SaveGame()
	
	//message("HERE")
	//Reset the UI Elements
	SetUI()
	SetSpriteDepth(ViewGotAway,0)
	if Player.TutorialState = 2
		Player.TutorialState = 3
		exitfunction
	endif
	if Player.TutorialState = 3
		Player.TutorialState = 4
		exitfunction
	endif
	if Player.TutorialState = 4
		Player.TutorialState = 5
		exitfunction
	endif
endfunction

//Show the Messages from the Users Phone
function ShowMessage(ID as Integer)
	LoadMessage(ID)
	CurrentMessageEntryCounter = 1
	GameState = GameStateMessage
	LastWindow = GameStateMessage
	SetSpriteVisible(ViewMessage,1)
	SetSpriteDepth(ViewMessage,1)
	SetTextVisible(LabelMessageTitle,1)
	SetTextVisible(LabelMessageBody,1)
	SetTextDepth(LabelMessageTitle,1)
	SetTextDepth(LabelMessageBody,1)
	SetTextVisible(Button[ButtonAcceptObjective].Label,1)
	SetSpriteVisible(Button[ButtonAcceptObjective].Sprite,1)
	SetSpriteDepth(Button[ButtonAcceptObjective].Sprite,1)
	
	SetSpritePosition(ViewMessage, ViewLeft + (ScreenWidth / 2) - (GetSpriteWidth(ViewMessage) / 2), ViewTop + 50)
	SetTextPosition(LabelMessageTitle,ViewLeft + ScreenWidth / 2, ViewTop + 150)
	SetTextPosition(LabelMessageBody,ViewLeft + ScreenWidth / 2, ViewTop + 240)
	SetSpritePosition(Button[ButtonAcceptObjective].Sprite,ViewLeft + ScreenWidth / 2 - GetSpriteWidth(Button[ButtonAcceptObjective].Sprite) / 2, ViewTop + 450)
	SetTextPosition(Button[ButtonAcceptObjective].Label,ViewLeft + ScreenWidth / 2, ViewTop + 470)
	Button[ButtonAcceptObjective].X = ScreenWidth / 2 - GetSpriteWidth(Button[ButtonAcceptObjective].Sprite) / 2
	Button[ButtonAcceptObjective].Y = 450
	SetTextColor(LabelMessageTitle,139,117,189,255)
	SetTextString(LabelMessageTitle,CurrentMessageTitle)
	SetTextString(LabelMessageBody,CurrentMessageEntry[CurrentMessageEntryCounter])
	
	SetSpriteDepth(Location[Player.CurrentLocation].AirportSprite,3)
	SetTextDepth(Location[Player.CurrentLocation].AirportLabel,3)
	SetSpriteDepth(Button[ButtonMessages].Sprite,3)
	SetTextDepth(Button[ButtonMessages].Label,3)
	SetTextDepth(Button[ButtonAcceptObjective].Label,0)
	
				
endfunction

//Update the message text
function UpdateMessage()
	CurrentMessageEntryCounter = CurrentMessageEntryCounter + 1
	if CurrentMessageEntryCounter > CurrentMessageEntries
		CurrentMessageEntryCounter = CurrentMessageEntries
	endif
	SetTextString(LabelMessageBody, CurrentMessageEntry[CurrentMessageEntryCounter])
endfunction

//Show a New Objective
function ShowObjective(ID as integer)
	GameState = GameStateObjective
	SetSpriteVisible(ViewObjective,1)
	SetSpriteDepth(ViewObjective,1)
	SetSpritePosition(ViewObjective, ViewLeft + (ScreenWidth / 2)  - (GetSpriteWidth(ViewObjective) / 2), ViewTop + 50)
	SetTextString(LabelObjective,Objective[ID].LabelString)
	SetTextPosition(LabelObjective,ViewLeft + (ScreenWidth / 2), ViewTop + 300)
	Button[ButtonAcceptObjective].X = ViewLeft + (ScreenWidth / 2) - (GetSpriteWidth(Button[ButtonAcceptObjective].Sprite) / 2)
	Button[ButtonAcceptObjective].Y = ViewTop + 400
	SetTextVisible(Button[ButtonAcceptObjective].Label,1)
	SetSpritePosition(Button[ButtonAcceptObjective].Sprite,Button[ButtonAcceptObjective].X,Button[ButtonAcceptObjective].Y)
	SetTextPosition(Button[ButtonAcceptObjective].Label,Button[ButtonAcceptObjective].X + 180,Button[ButtonAcceptObjective].Y + 20)
	SetTextDepth(Button[ButtonAcceptObjective].Label,0)
	SetTextVisible(LabelObjective,1)
	SetTextDepth(LabelObjective,0)
	SetSpriteVisible(Button[ButtonAcceptObjective].Sprite,1)
	SetSpriteDepth(Button[ButtonAcceptObjective].Sprite,1)
	SetSpriteVisible(ViewHoverBed,0)
	SetSpriteVisible(ViewHoverDoor,0)
	SetSpriteVisible(ViewHoverMessages,0)
endfunction

//Hide the Objective Window
function CloseObjective()
	SetSpriteVisible(ViewObjective,0)
	SetTextVisible(LabelObjective,0)
	SetSpriteVisible(Button[ButtonAcceptObjective].Sprite,0)
	SetTextVisible(Button[ButtonAcceptObjective].Label,0)
	GameState = GameStateMap
endfunction

//Busted by the Cops
function Busted()
	Cost = 0
	GameState = GameStateBusted
	HideElements()
	ViewLeft = 0
	ViewTop = 0
	SetViewOffset(ViewLeft,ViewTop)
	SetSpriteVisible(ViewBustedBackground,1)
	SetSpriteVisible(ViewBusted,1)
	SetSpriteVisible(Button[ButtonBustedContinue].Sprite,1)
	SetTextVisible(Button[ButtonBustedContinue].Label,1)
	SetSpritePosition(ViewBustedBackground,ViewLeft,ViewTop)
	SetSpritePosition(ViewBusted,ViewLeft + (ScreenWidth / 2) - (GetSpriteWidth(ViewBusted) / 2), ViewTop + 50)
	Button[ButtonBustedContinue].X = ViewLeft + (ScreenWidth / 2) - (GetSpriteWidth(Button[ButtonBustedContinue].Sprite) / 2)
	Button[ButtonBustedContinue].Y = ViewTop + 400
	SetSpritePosition(Button[ButtonBustedContinue].Sprite, Button[ButtonBustedContinue].X, Button[ButtonBustedContinue].Y)
	SetTextPosition(Button[ButtonBustedContinue].Label, Button[ButtonBustedContinue].X + GetSpriteWidth(Button[ButtonBustedContinue].Sprite) / 2, Button[ButtonBustedContinue].Y + 20)
	SetTextVisible(LabelBusted,1)
	SetTextPosition(LabelBusted,ViewLeft + (ScreenWidth / 2), 300)
	SetSpriteDepth(ViewBustedBackground,3)
	SetSpriteDepth(ViewBusted,2)
	SetSpriteDepth(Button[ButtonBustedContinue].Sprite,1)
	SetTextDepth(Button[ButtonBustedContinue].Label,1)
	SetTextDepth(LabelBusted,2)
	Player.NumBusted = Player.NumBusted + 1
	
	//Let's Determine if the User Can Continue or if they get Game Over?
	if Player.NumBusted = 1
		Cost = 500
	endif
	if Player.NumBusted = 2
		Cost = 1000
	endif
	if Player.NumBusted = 3
		Cost = 2500
	endif
	if Player.NumBusted = 4
		Cost = 5000
	endif
	if Player.NumBusted = 5
		Cost = 10000
	endif
	if Player.NumBusted = 6
		Cost = 50000
	endif
	if Player.NumBusted => 7
		Cost = 100000
	endif
	
	if GameOver = 2
		SetSpriteVisible(ViewBusted,0)
		SetTextString(LabelBusted,"You didn't earn back the $500,000 in bad debt.  You were never heard from again.  Fuck.")
		SetTextString(Button[ButtonBustedContinue].Label,"Return to main Menu")
		GameOver = 1
		exitfunction
	endif
	//If they can afford it! Let's post bail!
	if Player.Cash => Cost
		Player.Cash = Player.Cash - Cost
		SetSpriteImage(ViewBusted,ImageBusted)
		GameOver = 0
		SetTextString(LabelBusted,"Bummer. You were busted by the cops.  You paid " + str(Cost) + " in bail!")
		SetTextString(Button[ButtonBustedContinue].Label,"Continue...")
	endif
	if Player.Cash < Cost
		Player.Cash = Player.Cash - Cost
		SetSpriteImage(ViewBusted,ImageBusted)
		GameOver = 1
		SetTextString(LabelBusted,"You were busted by the cops and can't afford bail!  Looks like you'll be spending the rest of your life behind bars!")
		SetTextString(Button[ButtonBustedContinue].Label,"Return to Main Menu...")
	endif
	
	//If they can't afford it, it's game over bitches!
	
	
	SaveGame()
endfunction

//New Game
function NewGame()
	
	LastSecond = 0
	CurrentSecond = 0
	ResetTimer()
	
	//Reset Player Data
	CurrentDay = 0
	Player.X = 0
	Player.Y = 0
	Player.MaxItems = 50
	Player.MinItems = 0
	Player.Resource1Amount = 0
	Player.Resource2Amount = 0
	Player.Resource3Amount = 0
	Player.Resource4Amount = 0
	Player.Resource5Amount = 0
	Player.Resource6Amount = 0
	Player.Resource7Amount = 0
	Player.Resource8Amount = 0
	Player.Resource9Amount = 0
	Player.CurrentLocation = 1
	Player.LastLocation = 0
	Player.LastBuyLocation = 0
	Player.LastSellLocation = 0
	Player.Cash = 500
	Player.CurrentObjective = 1
	Player.CurrentMilestone = 0
	Player.CurrentPhoneMessage = 0
	Player.Debug = 0
	Player.Debt = 500000
	Player.Energy = 10
	Player.CurrentMessage = 1
	Player.TutorialState = 1
	Player.Day = 0
	SetSpriteVisible(Player.Sprite,1)
	SetSpritePosition(Player.Sprite,Player.X,Player.Y)
	NewDay()
	//Save the Game Data
	SaveGame()
	
	//Go to the Scene!
	ShowHome()
	
	//At the very start of the game, let's hide the  GUI buttons
	SetSpriteVisible(Location[1].AirportSprite,0)
	SetTextVisible(Location[1].AirportLabel,0)
	SetSpriteVisible(Button[ButtonMessages].Sprite,0)
	SetTextVisible(Button[ButtonMessages].Label,0)
	
	
	//Show the Initial Objective!
	//ShowObjective(Player.CurrentObjective)
	ShowMessage(1)
endfunction

//Startup
function Startup()
	ItsTheCopsTimer = 0
	ScrollBarDown = 0
	DidSwitch = 0
	TapTick = 1000
	RunMode = 1
	LastWindow = 0
	LoadImages()
	LoadMusics()
	CreateViews()
	CreatePlayer()
	CreateLabels()
	LoadButtons()
	LoadResources()
	LoadLocations()
	LoadObjectives()
	CreateFallingItems()
	HideElements()
	MainMenu()
	
endfunction

//Show the Main Menu
function MainMenu()
	HideElements()
	ViewTop = 0
	ViewLeft = 0
	GameState = GameStateMainMenu
	SetViewOffset(ViewTop,ViewLeft)
	SetSpriteVisible(ViewBackground,1)
	SetSpriteVisible(ViewClouds,1)
	SetSpriteVisible(ViewForeground,1)
	SetSpriteVisible(ViewTitle,1)
	SetSpriteVisible(Button[ButtonNewGame].Sprite,1)
	SetSpriteVisible(Button[ButtonContinue].Sprite,1)
	SetSpriteVisible(Button[ButtonCredits].Sprite,1)
	Button[ButtonNewGame].X = ScreenWidth / 2 - Button[ButtonNewGame].Width / 2
	Button[ButtonContinue].X = ScreenWidth / 2 - Button[ButtonContinue].Width / 2
	Button[ButtonCredits].X = ScreenWidth - 130 // 2 - Button[ButtonCredits].Width / 2
	Button[ButtonCredits].Y = 30
	Button[ButtonNewGame].Y = 430
	Button[ButtonContinue].Y = 520
	
	SetSpritePosition(Button[ButtonNewGame].Sprite, Button[ButtonNewGame].X, Button[ButtonNewGame].Y)
	SetSpritePosition(Button[ButtonContinue].Sprite, Button[ButtonContinue].X, Button[ButtonContinue].Y)
	SetSpritePosition(Button[ButtonCredits].Sprite, Button[ButtonCredits].X, Button[ButtonCredits].Y)
	StopAllMusic()
	PlayMusicOGG(MusicTitle,1)
	
endfunction

//Hide all Elements
function HideElements()
	
	//Hide views
	SetSpriteVisible(ViewBackground,0)
	SetSpriteVisible(ViewForeground,0)
	SetSpriteVisible(ViewClouds,0)
	SetSpriteVisible(ViewTitle,0)
	SetSpriteVisible(Player.Sprite,0)
	SetSpriteVisible(ViewObjective,0)
	SetSpriteVisible(ViewMap,0)
	SetSpriteVisible(ViewArrow,0)
	SetSpriteVisible(ViewMapLogo,0)
	SetSpriteVisible(ViewBackgroundScene,0)
	SetSpriteVisible(ViewEnergyIcon,0)
	SetSpriteVisible(ViewMessage,0)
	SetSpriteVisible(ViewHoverBed,0)
	SetSpriteVisible(ViewHoverDoor,0)
	SetSpriteVisible(ViewHoverMessages,0)
	if GotAwayAlpha = 0
		SetSpriteVisible(ViewGotAway,0)
	endif
	for i = 1 to 10
		SetSpriteVisible(ViewEnergy[i],0)
	next i
	
	SetTextVisible(LabelTitleEnergy,0)
	SetTextVisible(LabelTitleMoney,0)
	SetTextVisible(LabelTitlePack,0)
	SetTextVisible(LabelMoney,0)
	SetTextVisible(LabelPack,0)
	
	//Hide Scene Elements
	SetTextVisible(SceneUI.LocationNameLabel,0)
	SetTextVisible(SceneUI.LocationTypeLabel,0)
	SetTextVisible(SceneUI.LocationActionLabel,0)
	SetTextVisible(SceneUI.ResourceNameLabel,0)
	SetTextVisible(SceneUI.ResourcePriceLabel,0)
	SetTextVisible(SceneUI.Resource1NameLabel,0)
	SetTextVisible(SceneUI.Resource1PriceLabel,0)
	SetTextVisible(SceneUI.Resource2NameLabel,0)
	SetTextVisible(SceneUI.Resource2PriceLabel,0)
	SetTextVisible(SceneUI.Resource3NameLabel,0)
	SetTextVisible(SceneUI.Resource3PriceLabel,0)
	SetTextVisible(SceneUI.Resource4NameLabel,0)
	SetTextVisible(SceneUI.Resource4PriceLabel,0)
	SetTextVisible(SceneUI.Resource5NameLabel,0)
	SetTextVisible(SceneUI.Resource5PriceLabel,0)
	SetTextVisible(SceneUI.ProcessLabel,0)
	SetTextVisible(SceneUI.ProcessTitleLabel,0)
	SetTextVisible(SceneUI.HeatLabel,0)
	SetTextVisible(SceneUI.SoldLabel,0)
	SetTextVisible(SceneUI.PlayerCashLabel,0)
	SetTextVisible(SceneUI.MoneyLabel,0)
	SetTextVisible(LabelMessageTitle,0)
	SetTextVisible(LabelMessageBody,0)
	SetTextVisible(LabelDays,0)
	
	SetSpriteVisible(SceneUI.Background,0)
	SetSpriteVisible(SceneUI.Resource1Checkbox,0)
	SetSpriteVisible(SceneUI.Resource2Checkbox,0)
	SetSpriteVisible(SceneUI.Resource3Checkbox,0)
	SetSpriteVisible(SceneUI.Resource4Checkbox,0)
	SetSpriteVisible(SceneUI.Resource5Checkbox,0)
	SetSpriteVisible(SceneUI.SellButton,0)
	SetSpriteVisible(SceneUI.BuyButton,0)
	SetSpriteVisible(SceneUI.BounceButton,0)
	SetSpriteVisible(SceneUI.HeatbarBackground,0)
	SetSpriteVisible(SceneUI.HeatbarForeground,0)
	SetSpriteVisible(SceneUI.StopSellingButton,0)
	SetSpriteVisible(SceneUI.Slider1Background,0)
	SetSpriteVisible(SceneUI.Slider2Background,0)
	SetSpriteVisible(SceneUI.Slider3Background,0)

	
	SetSpriteVisible(SceneUI.Slider1,0)
	SetSpriteVisible(SceneUI.Slider2,0)
	SetSpriteVisible(SceneUI.Slider3,0)

	SetTextVisible(SceneUI.HeatLabel,0)
	SetTextVisible(SceneUI.FreeSpaceLabel,0)
	SetTextVisible(SceneUI.BuyingSpaceLabel,0)
	SetTextVisible(SceneUI.PackLabel,0)
	SetSpriteVisible(ViewMoving,0)
	
	//Hide all buttons
	for i = 1 to NumButtons
		SetSpriteVisible(Button[i].Sprite,0)
		SetTextVisible(Button[i].Label,0)
	next i
	
	//Hide All Locations
	for i = 1 to NumLocations
		SetSpriteVisible(Location[i].Sprite,0)
		SetSpriteVisible(Location[i].BuySprite,0)
		SetSpriteVisible(Location[i].SellSprite,0)
		SetSpriteVisible(Location[i].HospitalSprite,0)
		SetSpriteVisible(Location[i].AirportSprite,0)
		SetSpriteVisible(Location[i].MapSprite,0)
		SetTextVisible(Location[i].AirportLabel,0)
		SetTextVisible(Location[i].HospitalLabel,0)
		SetTextVisible(Location[i].MapLabel,0)
	next i
	
	for i = 1 to 100
		SetSpriteVisible(FallingItem[i].Sprite,0)
	next i
	
	SetSpriteVisible(ViewItsTheCops,0)
	SetSpriteVisible(ViewRunning,0)
	SetSpriteVisible(ViewRunningBackground,0)
	SetSpriteVisible(ViewRunningBackgroundBlank,0)
	SetSpriteVisible(CopsUILeftButton,0)
	SetSpriteVisible(CopsUIRightButton,0)
	SetSpriteVisible(ViewBustedBackground,0)
	SetSpriteVisible(ViewBusted,0)
	SetTextVisible(LabelBusted,0)
	SetSpriteVisible(ViewBackgroundSleep,0)
	SetSpriteVisible(ViewTutorial,0)
	SetTextVisible(LabelTutorial,0)
endfunction

//Show the Location Information when you click on a new location
function ShowLocationOptions(ID as integer)
	//First Let's Center the Screen on this Location
	//If we can
	ViewTop = Location[i].MapY - (ScreenHeight / 2) + 50
	ViewLeft = Location[i].MapX - (ScreenWidth / 2) + 100
	if ViewTop < 0
		ViewTop = 0
	endif
	if ViewTop >= GetSpriteHeight(ViewMap) - ScreenHeight
		ViewTop = GetSpriteHeight(ViewMap) - ScreenHeight
	Endif
	if ViewLeft > GetSpriteWidth(ViewMap) - ScreenWidth
		ViewLeft = GetSpriteWidth(ViewMap) - ScreenWidth
	endif
	if ViewLeft < 0
		ViewLeft = 0
	endif
	
	//Set the GameState
	GameState = GameStateLocationOptions
	
	SetViewOffset(ViewLeft,ViewTop)
	SetUI()
	SetSpriteVisible(Button[ButtonCancelLocation].Sprite,1)
	SetSpriteVisible(Button[ButtonGoToLocation].Sprite,1)
	
	SetSpriteDepth(Button[ButtonCancelLocation].Sprite,1)
	SetSpriteDepth(Button[ButtonGoToLocation].Sprite,1)
	
	SetSpriteVisible(ViewArrow,1)
	SetSpriteDepth(ViewArrow,1)
	SetSpritePosition(ViewArrow, Location[ID].MapX + 30, Location[ID].MapY - 60)
	//ShowItsTheCops()
endfunction

Startup()

do
    
	
	CurrentSecond = Timer()
	Difference = CurrentSecond - LastSecond
	if Difference = 1
		LastSecond = CurrentSecond
	endif
	
	if GameState = GameStateSleep
		if SleepDirection = 1
			SleepAlpha = SleepAlpha + 5
			if SleepAlpha => 255
				SleepAlpha = 255
				SleepDirection = 2
			endif
			SetSpriteColorAlpha(ViewBackgroundSleep,SleepAlpha)
		endif
		if SleepDirection = 2 
			SleepAlpha = SleepAlpha - 5
			if SleepAlpha <=0
				SleepAlpha = 0
				GameState = GameStateInScene
				SetSpriteVisible(ViewBackgroundSleep,0)
				ShowHome()
			endif
			SetSpriteColorAlpha(ViewBackgroundSleep,SleepAlpha)
		endif
	endif
	
	if GameState = GameStateMap
		if GetSpriteVisible(ViewGotAway) = 1
			GotAwayAlpha = GotAwayAlpha - 5
			if GotAwayAlpha <= 0
				GotAwayAlpha = 0
				SetSpriteVisible(ViewGotAway,0)
			endif
			if GotAwayAlpha > 0
				SetSpriteColor(ViewGotAway,255,255,255,GotAwayAlpha)
			endif
		endif
	endif
	
	//Are we at the Moving Scene?
	if GameState = GameStateMoving
		if EnergyAlpha > 0
			EnergyAlpha = EnergyAlpha - 200
			if EnergyAlpha <= 0
				EnergyAlpha = 0
				MovingX = ViewLeft - 1136
				MovingY = ViewTop
				SetSpritePosition(ViewMoving,MovingX,MovingY)
				SetSpriteVisible(ViewMoving,1)
				SetSpriteDepth(ViewMoving,0)
				IsMoving = 1
			endif
		endif
		if IsMoving = 1
			MovingX = MovingX + 30
			//if MovingX > ViewLeft //+ 200
			//	MovingX = ViewLeft// + 200
			//endif
			SetSpritePosition(ViewMoving,MovingX,MovingY)
			SetSpriteSize(ViewMoving,1136,640)
			
			if MovingX => ViewLeft 
				
			//	ViewLeft = ViewLeft + 200
				if tmpLocation > 1
					ShowScene(tmpLocation)
					MovingX = MovingX + 195
					SetSpritePosition(ViewMoving,MovingX,MovingY)
				endif
				if tmpLocation = 1
					ViewTop = 0
					ViewLeft = 0
					MovingY = 0
					MovingX = 0
					SetViewOffset(ViewLeft,ViewTop)
					ShowHome()
					SetSpritePosition(ViewMoving,MovingX,MovingY)
				endif
				//MovingX = ViewLeft + 200
				//if tmpLocation > 1
				//	MovingX = ViewLeft + 200
				//endif
				
				
				PlaySprite(ViewMoving,12,0,1,24)
				SetSpriteVisible(ViewMoving,1)
				SetSpriteDepth(ViewMoving,0)
				IsMoving = 2
			endif
		endif
		if IsMoving = 2 and GetSpriteCurrentFrame(ViewMoving) = 24
				MovingX = MovingX + 30
				SetSpritePosition(ViewMoving,MovingX,MovingY)
				if MovingX > ViewLeft + 1136
					SetSpriteVisible(ViewMoving,0)
					IsMoving = 0
					if Location[tmpLocation].LocationType = LocationTypeSell
						GameState = GameStateSellScene
					endif
					if Location[tmpLocation].LocationType = LocationTypeBuy
						GameState = GameStateBuyScene
					endif
					if tmpLocation = 1
						GameState = GameStateInScene

					endif
				endif	
		endif
		//print(IsMoving)
		//print(GetSpriteCurrentFrame(ViewMoving))
	endif
	
	//Are we at the running away scene?
	if GameState = GameStateRunAway
		Chance = Random(1,100)
		SpawnTick = SpawnTick - 1
		if SpawnTick <= 0
			SpawnFallingItem()
		endif
		
		//This is Old Code, Not Used. If you change RunMode = 0 this code will be used
		for i = 1 to 100
			if FallingItem[i].Active = 1
				FallingItem[i].Y = FallingItem[i].Y + FallingItem[i].Speed
				SetSpritePosition(FallingItem[i].Sprite,FallingItem[i].X,FallingItem[i].Y)
				SetSpriteDepth(FallingItem[i].Sprite,1)
				if FallingItem[i].Y > ViewTop + 700
					FallingItem[i].Active = 0
					SetSpriteVisible(FallingItem[i].Sprite,0)
				endif
			endif
			
		next i
		
		
		TapTick = TapTick + 1
		if TapTick => 1
			if RunMode = 0 //or RunMode = 1
				if TicksPassed > 1 and TicksPassed < 100
					CurrentDistance = CurrentDistance + 1
				endif
				if TicksPassed => 100 and TicksPassed < 300
					CurrentDistance = CurrentDistance + 2
				endif
				if TicksPassed => 300 and TicksPassed < 500
					CurrentDistance = CurrentDistance + 3
				endif
				if TicksPassed => 500 //and TicksPassed < 50
					CurrentDistance = CurrentDistance + 4
				endif
			endif
			if RunMode = 1 
				if TicksPassed > 1 and TicksPassed < 500
					CurrentDistance = CurrentDistance + 1
				endif
				if TicksPassed => 500 and TicksPassed < 1000
					CurrentDistance = CurrentDistance + 2
				endif
				if TicksPassed => 1000 
					CurrentDistance = CurrentDistance + 3
				endif
			endif
			if CurrentDistance => ScreenWidth
				Busted()
			endif
			//if RunMode = 1
			//	CurrentDistance = CurrentDistance + 1
			//endif
			
			TapTick = 0
			
			
			SetSpriteSize(ViewRunningBackground,CurrentDistance,640)
		endif
		TicksPassed = TicksPassed + 1
		
		//print(SpawnTick)
		//print(TicksPassed)
	endif
	
	//Transiton Left from Cops to Running!
	if GameState = GameStateRunIntro
		if ItsTheCopsTimer = 1
			ItsTheCopsX = ItsTheCopsX - 30
			SetSpritePosition(ViewItsTheCops, ItsTheCopsX, GetSpriteY(ViewItsTheCops))
			if GetSpriteX(ViewItsTheCops) < ViewLeft - 1200
				GameState = GameStateRunAway
			endif
			
		endif
	endif
	
	//Do Zoom and Spin for Its the Cops
	if GameState = GameStateItsTheCops
		
		if LastSecond = 2
			if ItsTheCopsTimer = 1
				GameState = GameStateRunIntro
				ShowTimeToRun()
			endif
		endif
	
	 CopsWidth = CopsWidth + 30
	 CopsHeight = CopsHeight + 20
	 
	  if CopsWidth < 1136
		SetSpriteAngle(ViewItsTheCops,CopsAngle)
		CopsAngle = CopsAngle + 10
	 endif
	
	 
	 if CopsWidth => 1136
		CopsWidth = 1136
		CopsHeight = 640
		if LastSpin = 0
			LastSpin = 1
		endif
	 endif
	 if CopsAngle => 360
		 CopsAngle = 0
	 endif
	
	 
	 
	if LastSpin = 1
		CopsAngle = CopsAngle + 10
		SetSpriteAngle(ViewItsTheCops,CopsAngle)
		if CopsAngle => 360
			LastSpin = 2
			if GetSpritePlaying(ViewItsTheCops) = 0
				ItsTheCopsX = ViewLeft + 0
				ItsTheCopsY = ViewTop + 0
				//SetViewOffset(ItsTheCopsX,ItsTheCopsY)
				SetSpritePosition(ViewItsTheCops, 0, 0)
				PlaySprite(ViewItsTheCops,4,1,1,2)
				ResetTimer()
				LastSecond = 0
				CurrentSecond = 0
				ItsTheCopsTimer = 1
			endif
			
		endif
	endif
	//print(LastSpin)
	// print(str(GetSpriteX(ViewItsTheCops)))
	// print(str(GetSpriteY(ViewItsTheCops)))
	 
	 SetSpriteSize(ViewItsTheCops,CopsWidth,CopsHeight)
	 SetSpritePosition(ViewItsTheCops,ViewLeft + (1136 / 2) - CopsWidth / 2 ,ViewTop + (640 / 2) - CopsHeight / 2)
	
	 
	endif
	
	//print(LastSecond)
	//print(CurrentSecond)
	//print(Difference)
	
	//If we are Selling, let's randomly sell resources and stuff
	if GameState = GameStateSelling
		SetTextColor(SceneUI.LocationTypeLabel,255,0,0,SceneUI.LocationTypeAlpha)
		if SceneUI.LocationTypeDirection = 1
			SceneUI.LocationTypeAlpha = SceneUI.LocationTypeAlpha - 5
			if SceneUI.LocationTypeAlpha <= 0 
				SceneUI.LocationTypeAlpha = 0
				SceneUI.LocationTypeDirection = 2
			endif
		endif
		if SceneUI.LocationTypeDirection = 2
			SceneUI.LocationTypeAlpha = SceneUI.LocationTypeAlpha + 5
			if SceneUI.LocationTypeAlpha >= 255
				SceneUI.LocationTypeAlpha = 255
				SceneUI.LocationTypeDirection = 1
			endif
		endif
		
		
		//Sell a Resource Every Few Seconds!
		if LastSecond = SellTick
			if Location[Player.CurrentLocation].CurrentHeat => 99
				ShowItsTheCops()
			endif
			
			OldDistance = CurrentDistance
			KeepSelling = 0
			SoldResource = 0
			if SellResource1 = 1
				if Player.Resource1Amount > 0 and SoldResource = 0
					KeepSelling = 1
					OldHeatbarWidth = GetSpriteWidth(SceneUI.HeatbarForeground)
					CurrentSaleAmount = Random(1,5)
					if CurrentSaleAmount >= Player.Resource1Amount
						CurrentSaleAmount = Player.Resource1Amount
					endif
					HeatMultiplier = Random(1,2)
					CurrentSale = Location[Player.CurrentLocation].Resource1Price * CurrentSaleAmount
					if Location[Player.CurrentLocation].CurrentHeat < 40
						CurrentSale = CurrentSale
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 40 and Location[Player.CurrentLocation].CurrentHeat < 60
						CurrentSale = CurrentSale * 1.5
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 60 and Location[Player.CurrentLocation].CurrentHeat < 80
						CurrentSale = CurrentSale * 1.75
					endif
					if Location[Player.CurrentLocation].CurrentHeat > 80
						CurrentSale = CurrentSale * 2
					endif
					CurrentSaleTotal = CurrentSaleTotal + CurrentSale
					Player.Resource1Amount = Player.Resource1Amount - CurrentSaleAmount
					Player.Cash = Player.Cash + CurrentSale
					Player.MinItems = Player.MinItems - CurrentSaleAmount
					SetTextString(SceneUI.ProcessLabel,"$" + str(CurrentSaleTotal))
					tmpString = Resource[1] + " (" + str(Player.Resource1Amount) + "G)"
					SetTextString(SceneUI.Resource1NameLabel, tmpString)
					SetTextVisible(SceneUI.SoldLabel,1)
					SetTextString(SceneUI.SoldLabel,"+ $" + str(CurrentSale))
					SceneUI.SoldLabelX = ViewLeft + Random(300,400)
					SceneUI.SoldLabelY = ViewTop + Random(300,400)
					SceneUI.SoldLabelAlpha = 255
					SetTextPosition(SceneUI.SoldLabel,SceneUI.SoldLabelX,SceneUI.SoldLabelY)
					SetTextDepth(SceneUI.SoldLabel,1)
					PlaySound(SoundSell)
					AddHeat = CurrentSaleAmount * HeatMultiplier
					Location[Player.CurrentLocation].CurrentHeat = Location[Player.CurrentLocation].CurrentHeat + AddHeat
					NewHeatbarWidth = (Location[Player.CurrentLocation].CurrentHeat / GetSpriteWidth(SceneUI.HeatbarBackground)) / (100 / GetSpriteWidth(SceneUI.HeatbarBackground)) * GetSpriteWidth(SceneUI.HeatbarBackground)
					
					//Chance of Being Caught
					Chance = Random(1,100)
					if Location[Player.CurrentLocation].CurrentHeat < 20
						if Chance < 10
							StopSelling()
							ShowItsTheCops()
						endif
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 20 and Location[Player.CurrentLocation].CurrentHeat < 40 
						if Chance < 25
							StopSelling()
							ShowItsTheCops()
						endif
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 40 and Location[Player.CurrentLocation].CurrentHeat < 60 
						if Chance < 50
							StopSelling()
							ShowItsTheCops()
						endif
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 60 and Location[Player.CurrentLocation].CurrentHeat < 80 
						if Chance < 75
							StopSelling()
							ShowItsTheCops()
						endif
					endif
					
					SoldResource = 1
					if Player.Resource1Amount <= 0
						SetTextColor(SceneUI.Resource1NameLabel,255,0,0,255)
					endif
					SetTextString(SceneUI.PlayerCashLabel,"Cash: $" + str(Player.Cash))
					SetTextString(SceneUI.PackLabel,"Pack: " + str(Player.MinItems) + "/" + str(Player.MaxItems))
					CurrentDistance =  (Location[Player.CurrentLocation].CurrentHeat * 1136) / 100
					DistanceDirection = 1
				endif
			endif
			if SellResource2 = 1
				if Player.Resource2Amount > 0 and SoldResource = 0
					KeepSelling = 1
					OldHeatbarWidth = GetSpriteWidth(SceneUI.HeatbarForeground)
					CurrentSaleAmount = Random(1,2)
					if CurrentSaleAmount >= Player.Resource2Amount
						CurrentSaleAmount = Player.Resource2Amount
					endif
					HeatMultiplier = Random(1,3)
					CurrentSale = Location[Player.CurrentLocation].Resource2Price * CurrentSaleAmount
					if Location[Player.CurrentLocation].CurrentHeat < 40
						CurrentSale = CurrentSale
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 40 and Location[Player.CurrentLocation].CurrentHeat < 60
						CurrentSale = CurrentSale * 1.5
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 60 and Location[Player.CurrentLocation].CurrentHeat < 80
						CurrentSale = CurrentSale * 1.75
					endif
					if Location[Player.CurrentLocation].CurrentHeat > 80
						CurrentSale = CurrentSale * 2
					endif
					CurrentSaleTotal = CurrentSaleTotal + CurrentSale
					Player.Resource2Amount = Player.Resource2Amount - CurrentSaleAmount
					Player.Cash = Player.Cash + CurrentSale
					Player.MinItems = Player.MinItems - CurrentSaleAmount
					SetTextString(SceneUI.ProcessLabel,"$" + str(CurrentSaleTotal))
					tmpString = Resource[2] + " (" + str(Player.Resource2Amount) + "G)"
					SetTextString(SceneUI.Resource2NameLabel, tmpString)
					SetTextVisible(SceneUI.SoldLabel,1)
					SetTextString(SceneUI.SoldLabel,"+ $" + str(CurrentSale))
					SceneUI.SoldLabelX = ViewLeft + Random(300,400)
					SceneUI.SoldLabelY = ViewTop + Random(300,400)
					SceneUI.SoldLabelAlpha = 255
					PlaySound(SoundSell)
					SetTextPosition(SceneUI.SoldLabel,SceneUI.SoldLabelX,SceneUI.SoldLabelY)
					SetTextDepth(SceneUI.SoldLabel,1)
					AddHeat = CurrentSaleAmount * HeatMultiplier
					Location[Player.CurrentLocation].CurrentHeat = Location[Player.CurrentLocation].CurrentHeat + AddHeat
					NewHeatbarWidth = (Location[Player.CurrentLocation].CurrentHeat / GetSpriteWidth(SceneUI.HeatbarBackground)) / (100 / GetSpriteWidth(SceneUI.HeatbarBackground)) * GetSpriteWidth(SceneUI.HeatbarBackground)
					//Chance of Being Caught
					Chance = Random(1,100)
					if Location[Player.CurrentLocation].CurrentHeat < 20
						if Chance < 10
							StopSelling()
							ShowItsTheCops()
						endif
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 20 and Location[Player.CurrentLocation].CurrentHeat < 40 
						if Chance < 25
							StopSelling()
							ShowItsTheCops()
						endif
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 40 and Location[Player.CurrentLocation].CurrentHeat < 60 
						if Chance < 50
							StopSelling()
							ShowItsTheCops()
						endif
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 60 and Location[Player.CurrentLocation].CurrentHeat < 80 
						if Chance < 75
							StopSelling()
							ShowItsTheCops()
						endif
					endif
					SoldResource = 1
					if Player.Resource2Amount <= 0
						SetTextColor(SceneUI.Resource2NameLabel,255,0,0,255)
					endif
					SetTextString(SceneUI.PlayerCashLabel,"Cash: $" + str(Player.Cash))
					SetTextString(SceneUI.PackLabel,"Pack: " + str(Player.MinItems) + "/" + str(Player.MaxItems))
					CurrentDistance =  (Location[Player.CurrentLocation].CurrentHeat * 1136) / 100
					DistanceDirection = 1
				endif
			endif
			if SellResource3 = 1
				if Player.Resource3Amount > 0 and SoldResource = 0
					KeepSelling = 1
					OldHeatbarWidth = GetSpriteWidth(SceneUI.HeatbarForeground)
					CurrentSaleAmount = Random(1,2)
					if CurrentSaleAmount >= Player.Resource3Amount
						CurrentSaleAmount = Player.Resource3Amount
					endif
					HeatMultiplier = Random(1,3)
					CurrentSale = Location[Player.CurrentLocation].Resource3Price * CurrentSaleAmount
					if Location[Player.CurrentLocation].CurrentHeat < 40
						CurrentSale = CurrentSale
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 40 and Location[Player.CurrentLocation].CurrentHeat < 60
						CurrentSale = CurrentSale * 1.5
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 60 and Location[Player.CurrentLocation].CurrentHeat < 80
						CurrentSale = CurrentSale * 1.75
					endif
					if Location[Player.CurrentLocation].CurrentHeat > 80
						CurrentSale = CurrentSale * 2
					endif
					CurrentSaleTotal = CurrentSaleTotal + CurrentSale
					Player.Resource3Amount = Player.Resource3Amount - CurrentSaleAmount
					Player.Cash = Player.Cash + CurrentSale
					Player.MinItems = Player.MinItems - CurrentSaleAmount
					SetTextString(SceneUI.ProcessLabel,"$" + str(CurrentSaleTotal))
					tmpString = Resource[3] + " (" + str(Player.Resource3Amount) + "G)"
					SetTextString(SceneUI.Resource3NameLabel, tmpString)
					SetTextVisible(SceneUI.SoldLabel,1)
					SetTextString(SceneUI.SoldLabel,"+ $" + str(CurrentSale))
					SceneUI.SoldLabelX = ViewLeft + Random(300,400)
					SceneUI.SoldLabelY = ViewTop + Random(300,400)
					SceneUI.SoldLabelAlpha = 255
					PlaySound(SoundSell)
					SetTextPosition(SceneUI.SoldLabel,SceneUI.SoldLabelX,SceneUI.SoldLabelY)
					SetTextDepth(SceneUI.SoldLabel,1)
					AddHeat = CurrentSaleAmount * HeatMultiplier
					Location[Player.CurrentLocation].CurrentHeat = Location[Player.CurrentLocation].CurrentHeat + AddHeat
					NewHeatbarWidth = (Location[Player.CurrentLocation].CurrentHeat / GetSpriteWidth(SceneUI.HeatbarBackground)) / (100 / GetSpriteWidth(SceneUI.HeatbarBackground)) * GetSpriteWidth(SceneUI.HeatbarBackground)
					//HeatbarWidth = (Location[Player.CurrentLocation].CurrentHeat / GetSpriteWidth(SceneUI.HeatbarBackground)) / (100 / GetSpriteWidth(SceneUI.HeatbarBackground)) * GetSpriteWidth(SceneUI.HeatbarBackground)
					//if HeatbarWidth > GetSpriteWidth(SceneUI.HeatbarBackground)
					//	HeatbarWidth = GetSpriteWidth(SceneUI.HeatbarBackground)
					//endif
					//SetSpriteSize(SceneUI.HeatbarForeground,HeatbarWidth,GetSpriteHeight(SceneUI.HeatbarForeground))
					//Chance of Being Caught
					Chance = Random(1,100)
					if Location[Player.CurrentLocation].CurrentHeat < 20
						if Chance < 10
							StopSelling()
							ShowItsTheCops()
						endif
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 20 and Location[Player.CurrentLocation].CurrentHeat < 40 
						if Chance < 25
							StopSelling()
							ShowItsTheCops()
						endif
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 40 and Location[Player.CurrentLocation].CurrentHeat < 60 
						if Chance < 50
							StopSelling()
							ShowItsTheCops()
						endif
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 60 and Location[Player.CurrentLocation].CurrentHeat < 80 
						if Chance < 75
							StopSelling()
							ShowItsTheCops()
						endif
					endif
					SoldResource = 1
					if Player.Resource3Amount <= 0
						SetTextColor(SceneUI.Resource3NameLabel,255,0,0,255)
					endif
					SetTextString(SceneUI.PlayerCashLabel,"Cash: $" + str(Player.Cash))
					SetTextString(SceneUI.PackLabel,"Pack: " + str(Player.MinItems) + "/" + str(Player.MaxItems))
					CurrentDistance =  (Location[Player.CurrentLocation].CurrentHeat * 1136) / 100
					DistanceDirection = 1
				endif
			endif
			if SellResource4 = 1
				if Player.Resource4Amount > 0 and SoldResource = 0
					KeepSelling = 1
					OldHeatbarWidth = GetSpriteWidth(SceneUI.HeatbarForeground)
					CurrentSaleAmount = Random(1,4)
					if CurrentSaleAmount >= Player.Resource4Amount
						CurrentSaleAmount = Player.Resource4Amount
					endif
					HeatMultiplier = Random(1,2)
					CurrentSale = Location[Player.CurrentLocation].Resource4Price * CurrentSaleAmount
					if Location[Player.CurrentLocation].CurrentHeat < 40
						CurrentSale = CurrentSale
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 40 and Location[Player.CurrentLocation].CurrentHeat < 60
						CurrentSale = CurrentSale * 1.5
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 60 and Location[Player.CurrentLocation].CurrentHeat < 80
						CurrentSale = CurrentSale * 1.75
					endif
					if Location[Player.CurrentLocation].CurrentHeat > 80
						CurrentSale = CurrentSale * 2
					endif
					CurrentSaleTotal = CurrentSaleTotal + CurrentSale
					Player.Resource4Amount = Player.Resource4Amount - CurrentSaleAmount
					Player.Cash = Player.Cash + CurrentSale
					Player.MinItems = Player.MinItems - CurrentSaleAmount
					SetTextString(SceneUI.ProcessLabel,"$" + str(CurrentSaleTotal))
					tmpString = Resource[4] + " (" + str(Player.Resource4Amount) + "G)"
					SetTextString(SceneUI.Resource4NameLabel, tmpString)
					SetTextVisible(SceneUI.SoldLabel,1)
					SetTextString(SceneUI.SoldLabel,"+ $" + str(CurrentSale))
					SceneUI.SoldLabelX = ViewLeft + Random(300,400)
					SceneUI.SoldLabelY = ViewTop + Random(300,400)
					SceneUI.SoldLabelAlpha = 255
					PlaySound(SoundSell)
					SetTextPosition(SceneUI.SoldLabel,SceneUI.SoldLabelX,SceneUI.SoldLabelY)
					SetTextDepth(SceneUI.SoldLabel,1)
					AddHeat = CurrentSaleAmount * HeatMultiplier
					Location[Player.CurrentLocation].CurrentHeat = Location[Player.CurrentLocation].CurrentHeat + AddHeat
					NewHeatbarWidth = (Location[Player.CurrentLocation].CurrentHeat / GetSpriteWidth(SceneUI.HeatbarBackground)) / (100 / GetSpriteWidth(SceneUI.HeatbarBackground)) * GetSpriteWidth(SceneUI.HeatbarBackground)
					//if HeatbarWidth > GetSpriteWidth(SceneUI.HeatbarBackground)
					//	HeatbarWidth = GetSpriteWidth(SceneUI.HeatbarBackground)
					//endif
					//SetSpriteSize(SceneUI.HeatbarForeground,HeatbarWidth,GetSpriteHeight(SceneUI.HeatbarForeground))
					//Chance of Being Caught
					Chance = Random(1,100)
					if Location[Player.CurrentLocation].CurrentHeat < 20
						if Chance < 10
							StopSelling()
							ShowItsTheCops()
						endif
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 20 and Location[Player.CurrentLocation].CurrentHeat < 40 
						if Chance < 25
							StopSelling()
							ShowItsTheCops()
						endif
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 40 and Location[Player.CurrentLocation].CurrentHeat < 60 
						if Chance < 50
							StopSelling()
							ShowItsTheCops()
						endif
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 60 and Location[Player.CurrentLocation].CurrentHeat < 80 
						if Chance < 75
							StopSelling()
							ShowItsTheCops()
						endif
					endif
					SoldResource = 1
					if Player.Resource4Amount <= 0
						SetTextColor(SceneUI.Resource4NameLabel,255,0,0,255)
					endif
					SetTextString(SceneUI.PlayerCashLabel,"Cash: $" + str(Player.Cash))
					SetTextString(SceneUI.PackLabel,"Pack: " + str(Player.MinItems) + "/" + str(Player.MaxItems))
					CurrentDistance = (Location[Player.CurrentLocation].CurrentHeat * 1136) / 100
					DistanceDirection = 1
				endif
			endif
			if SellResource5 = 1
				if Player.Resource5Amount > 0 and SoldResource = 0
					KeepSelling = 1
					OldHeatbarWidth = GetSpriteWidth(SceneUI.HeatbarForeground)
					CurrentSaleAmount = Random(1,4)
					if CurrentSaleAmount >= Player.Resource5Amount
						CurrentSaleAmount = Player.Resource5Amount
					endif
					HeatMultiplier = Random(1,1)
					CurrentSale = Location[Player.CurrentLocation].Resource5Price * CurrentSaleAmount
					if Location[Player.CurrentLocation].CurrentHeat < 40
						CurrentSale = CurrentSale
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 40 and Location[Player.CurrentLocation].CurrentHeat < 60
						CurrentSale = CurrentSale * 1.5
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 60 and Location[Player.CurrentLocation].CurrentHeat < 80
						CurrentSale = CurrentSale * 1.75
					endif
					if Location[Player.CurrentLocation].CurrentHeat > 80
						CurrentSale = CurrentSale * 2
					endif
					CurrentSaleTotal = CurrentSaleTotal + CurrentSale
					Player.Resource5Amount = Player.Resource5Amount - CurrentSaleAmount
					Player.Cash = Player.Cash + CurrentSale
					Player.MinItems = Player.MinItems - CurrentSaleAmount
					SetTextString(SceneUI.ProcessLabel,"$" + str(CurrentSaleTotal))
					tmpString = Resource[5] + " (" + str(Player.Resource5Amount) + "G)"
					SetTextString(SceneUI.Resource5NameLabel, tmpString)
					SetTextVisible(SceneUI.SoldLabel,1)
					SetTextString(SceneUI.SoldLabel,"+ $" + str(CurrentSale))
					SceneUI.SoldLabelX = ViewLeft + Random(300,400)
					SceneUI.SoldLabelY = ViewTop + Random(300,400)
					SceneUI.SoldLabelAlpha = 255
					PlaySound(SoundSell)
					SetTextPosition(SceneUI.SoldLabel,SceneUI.SoldLabelX,SceneUI.SoldLabelY)
					SetTextDepth(SceneUI.SoldLabel,1)
					AddHeat = CurrentSaleAmount * HeatMultiplier
					Location[Player.CurrentLocation].CurrentHeat = Location[Player.CurrentLocation].CurrentHeat + AddHeat
					NewHeatbarWidth = (Location[Player.CurrentLocation].CurrentHeat / GetSpriteWidth(SceneUI.HeatbarBackground)) / (100 / GetSpriteWidth(SceneUI.HeatbarBackground)) * GetSpriteWidth(SceneUI.HeatbarBackground)
					//if HeatbarWidth > GetSpriteWidth(SceneUI.HeatbarBackground)
					//	HeatbarWidth = GetSpriteWidth(SceneUI.HeatbarBackground)
					//endif
					//SetSpriteSize(SceneUI.HeatbarForeground,HeatbarWidth,GetSpriteHeight(SceneUI.HeatbarForeground))
					//Chance of Being Caught
					Chance = Random(1,100)
					if Location[Player.CurrentLocation].CurrentHeat < 20
						if Chance < 10
							StopSelling()
							ShowItsTheCops()
						endif
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 20 and Location[Player.CurrentLocation].CurrentHeat < 40 
						if Chance < 25
							StopSelling()
							ShowItsTheCops()
						endif
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 40 and Location[Player.CurrentLocation].CurrentHeat < 60 
						if Chance < 50
							StopSelling()
							ShowItsTheCops()
						endif
					endif
					if Location[Player.CurrentLocation].CurrentHeat => 60 and Location[Player.CurrentLocation].CurrentHeat < 80 
						if Chance < 75
							StopSelling()
							ShowItsTheCops()
						endif
					endif
					SoldResource = 1
					if Player.Resource5Amount <= 0
						SetTextColor(SceneUI.Resource5NameLabel,255,0,0,255)
					endif
					SetTextString(SceneUI.PlayerCashLabel,"Cash: $" + str(Player.Cash))
					SetTextString(SceneUI.PackLabel,"Pack: " + str(Player.MinItems) + "/" + str(Player.MaxItems))
					CurrentDistance =  (Location[Player.CurrentLocation].CurrentHeat * 1136) / 100
					DistanceDirection = 1
				endif
			endif
			
			
			SellTick = Random(3,5)
			ResetTimer()
			LastSecond = 0 
			CurrentSecond = 0
			if KeepSelling = 0
				StopSelling()
			endif
		endif
		if GetTextVisible(SceneUI.SoldLabel) = 1
			SceneUI.SoldLabelY = SceneUI.SoldLabelY - 1
			SceneUI.SoldLabelAlpha = SceneUI.SoldLabelAlpha - 5
			SetTextPosition(SceneUI.SoldLabel, SceneUI.SoldLabelX, SceneUI.SoldLabelY)
			SetTextColor(SceneUI.SoldLabel, 255, 255, 255, SceneUI.SoldLabelAlpha)
			if SceneUI.SoldLabelAlpha <= 0 
				SetTextVisible(SceneUI.SoldLabel,0)
			endif
		endif
		//print(OldHeatbarWidth)
		//print(NewHeatbarWidth)
		
		if NewHeatbarWidth > OldHeatbarWidth
			HeatbarWidth = OldHeatbarWidth + 1
			if NewHeatbarWidth >= GetSpriteWidth(SceneUI.HeatbarBackground)
				NewHeatbarWidth = GetSpriteWidth(SceneUI.HeatbarBackground)
			endif
			
			//if HeatbarWidth >= OldHeatbarWidth
			//	HeatbarWidth = OldHeatbarWidth
			//endif
			//if HeatbarWidth > GetSpriteWidth(SceneUI.HeatbarBackground)
			//	HeatbarWidth = GetSpriteWidth(SceneUI.HeatbarBackground)
			//endif
			SetSpriteSize(SceneUI.HeatbarForeground,HeatbarWidth,GetSpriteHeight(SceneUI.HeatbarForeground))
			OldHeatbarWidth = GetSpriteWidth(SceneUI.HeatbarForeground)
		endif
		
		if Player.Resource1Amount = 0 and Player.Resource2Amount = 0 and Player.Resource3Amount = 0 and Player.Resource4Amount = 0 and Player.Resource5Amount = 0
			StopSelling()
		endif
		//print(GetSpriteColorAlpha(SceneUI.StopSellingButton))
		
	endif
	
	//If we are in a scene, let's animate the Icons!
	if GameState = GameStateInScene
	
	endif
	
	//Handle Input
	CheckInput()
	//print(ScreenFPS())
	//If Debug is Enabled, Print some Crucial Information to the Screen
	if Player.Debug = 1
		print("Current View Offset X: " + str(GetViewOffsetX()))
		print("Current View Offset Y: " + str(GetViewOffsetY()))
		print("View Top: " + str(ViewTop))
		print("View Left: " + str(ViewLeft))
		print("Original View Top: " + str(OriginalViewTop))
		print("Original View Left: " + str(OriginalViewLeft))
		print("Current Second: " + str(CurrentSecond))
		print("Last Second: " + str(LastSecond))
	endif
	//print(Location[Player.CurrentLocation].CurrentHeat)
    //Print( ScreenFPS() )
    Sync()
loop
