# PlatformControl Analyser

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC_BY--SA_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)

*This project is part of PlatformControl: <https://github.com/OxfordHCC/PlatformControl>*

This repo provides analysis scripts to automate the tracker analysis of iOS and Android apps, with both dynamic and static analysis.

**DISCLAIMER: The authors of this repository do not and cannot guarantee the accuracy of any data provided or any results obtained from the use of this software. Use of this repository is at your own risk. The data and code of this project are shared stricly *for research purposes only*.**

## Preparation

Both iOS and Android analysis need a text file, with each line pointing to an app file (either `*.apk` or `*.ipa` files):

- `./data/android_files.txt` for Android
- `./data/ios_files.txt` for iOS

You need to create such files manually before use and also provide app files to analyse.

The network traffic is monitored using `mitmproxy`, which must be installed on your system and on your phone (i.e. set-up proxy and install custom root certificates). On Android 7 or higher this needs root access.

For our tests, we used version `6.0.2` of `mitmproxy`. Higher versions are not supported. However, we provide the script `helpers/har_dump_v7.py` that should have compatibility with the latest version of the tool. It has, however, not been rigorously tested.

## iOS Setup

For iOS, install `frida` and `ideviceinstaller` on your computer. You also need to [jailbreak](https://docs.google.com/spreadsheets/d/11DABHIIqwYQKj1L83AK9ywk_hYMjEkcaxpIg6phbTf0/edit#gid=1014970938) your iOS device. Then, install [frida](https://frida.re/docs/ios/#with-jailbreak) and [ssl-kill-switch2](https://github.com/nabla-c0d3/ssl-kill-switch2) on your iOS device. Run `pkill itunesstored` on a bash console on your iOS before starting the analysis. Then, you can start the analysis using `processIpas.sh`.

If you're trying to install somewhat older `*.ipa` files, you might run into problems with the signature having become outdated. In that case, you can use [AppSync](https://github.com/akemin-dayo/AppSync).

## Android Setup

You need to install `adb`. Additionally, you can try to circumvent certificate pinning using [JustTrustMe](https://github.com/kasnder/JustTrustMe) and the Xposed Framework (root required). Lastly, you can start the analysis using `processApks.sh`.

For static analysis, use the [Exodus standalone script](https://github.com/Exodus-Privacy/exodus-standalone) on the apks: `python exodus_analyze.py -j app.apk`

Some apps manage to circumvent the proxy settings if entered in the system settings. For this reason, you might want to use an dedicated app that makes sure that all traffic is routed through the proxy. For instance, you could use a SOCKS proxy using [TrackerControl Slim](https://play.google.com/store/apps/details?id=net.kollnig.missioncontrol.play) (available on the Google Play Store---make sure you enable the monitoring of System Apps).

## Credits

- https://github.com/mitmproxy/mitmproxy
- https://github.com/noobpk/frida-ios-hook
- https://github.com/Exodus-Privacy/exodus-standalone
- https://github.com/Fuzion24/JustTrustMe
- https://github.com/kasnder/JustTrustMe
- https://play.google.com/store/apps/details?id=net.kollnig.missioncontrol.play
- https://github.com/nabla-c0d3/ssl-kill-switch2

## Citation

If you use this project as part of your academic studies, please kindly cite the below article:

```
@article{kollnig2022_iphone_android,
      title={Are iPhones Really Better for Privacy? A Comparative Study of iOS and Android Apps}, 
      author={Konrad Kollnig and Anastasia Shuba and Reuben Binns and Max {Van Kleek} and Nigel Shadbolt},
      year={2022},
      journal={Proceedings on Privacy Enhancing Technologies}
}
```

## License

Most of the code is licensed under GPLv3, with two exceptions: `helpers/find-all-classes.js` (originally taken from [mitmproxy](https://github.com/mitmproxy/mitmproxy)) and `helpers/har_dump.py` (originally taken from [frida-ios-hook](https://github.com/noobpk/frida-ios-hook)) are licensed under an MIT License.

Any data in this project is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/), in particular our iOS tracker signatures in `data/ios_signatures.json`.
