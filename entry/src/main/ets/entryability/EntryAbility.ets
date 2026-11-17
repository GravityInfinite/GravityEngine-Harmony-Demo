import {
  abilityAccessCtrl,
  AbilityConstant,
  ConfigurationConstant,
  PermissionRequestResult,
  UIAbility,
  Want
} from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { GravityEngineSDK, gravityConfig } from '@gravityengine/analytics'

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    // hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');

    this.geStart(want)
  }

  async geStart(want: Want) {
    const config = new gravityConfig({
      context: this.context,
      accessToken: "i0wzaXsosEVJuev7bn8pRl1vLSgcAhoj",
      clientId: "sadhfywevhcubi_001",
      debugMode: 'none',
      clientIdPriorityOrder: ["ANDROID_ID"],
      wantParameters: want.parameters,
      presetSuperProperties:{"testSuperKey":"testSuperValue"},
      disableScreen:true
    })
    GravityEngineSDK.enableLog(true)
    await GravityEngineSDK.setupAndStart(config)
    const t = GravityEngineSDK.getCurrentClientId();
    console.log("gravityAnalytics getCurrentClientId=", t)
  }


  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  // on show
  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }


  // on hide
  onBackground(): void {
    // setInterval(() => {
    //   console.log('4444')
    // }, 30)
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}