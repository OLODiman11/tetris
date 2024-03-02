class_name Ad

extends Node2D

var _interstitial_ad : InterstitialAd
var _full_screen_content_callback : FullScreenContentCallback
var _unit_id : String

func _ready():
	if OS.get_name() == "Android":
		_unit_id = "ca-app-pub-3940256099942544/1033173712"
	elif OS.get_name() == "iOS":
		_unit_id = "ca-app-pub-3940256099942544/4411468910"
		
	_full_screen_content_callback = FullScreenContentCallback.new()
	_full_screen_content_callback.on_ad_clicked = func() -> void:
		print("on_ad_clicked")
	_full_screen_content_callback.on_ad_dismissed_full_screen_content = func() -> void:
		print("on_ad_dismissed_full_screen_content")
		destroy_ad()
	_full_screen_content_callback.on_ad_failed_to_show_full_screen_content = func(ad_error : AdError) -> void:
		print("on_ad_failed_to_show_full_screen_content")
		destroy_ad()
	_full_screen_content_callback.on_ad_impression = func() -> void:
		print("on_ad_impression")
	_full_screen_content_callback.on_ad_showed_full_screen_content = func() -> void:
		print("on_ad_showed_full_screen_content")
	
func load_ad():	
	if _interstitial_ad:
		_interstitial_ad.destroy()
		_interstitial_ad = null

	var interstitial_ad_load_callback := InterstitialAdLoadCallback.new()
	interstitial_ad_load_callback.on_ad_failed_to_load = func(adError : LoadAdError) -> void:
		print(adError.message)

	interstitial_ad_load_callback.on_ad_loaded = func(interstitial_ad : InterstitialAd) -> void:
		print("interstitial ad loaded" + str(interstitial_ad._uid))
		_interstitial_ad = interstitial_ad
		_interstitial_ad.full_screen_content_callback = _full_screen_content_callback
		show_ad()

	InterstitialAdLoader.new().load(_unit_id, AdRequest.new(), interstitial_ad_load_callback)

func show_ad():
	if _interstitial_ad:
		_interstitial_ad.show()
		
func destroy_ad():
	if _interstitial_ad:
		_interstitial_ad.destroy()
		_interstitial_ad = null
