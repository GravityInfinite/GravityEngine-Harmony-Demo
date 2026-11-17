import { GravityEngineSDK } from '@gravityengine/analytics';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { JSON } from '@kit.ArkTS';

@Entry
@Component
struct Index {
  private btnList: string[] = [
    "initialize",
    "track",
    "timeEvent",
    "payEvent",
    "adShowEvent",
    "userSet",
    "userSetOnce",
    "setSuperProperties",
    "getSuperProperties",
    "userUnset",
    "userAdd",
    "userUniqAppend",
    "userAppend",
    "flush",
    "unsetSuperProperty",
    "clearSuperProperties",
    "userNumberMax",
    "userNumberMin",
    "userDel",
    "getDeviceId",
    "getPresetProperties"
  ];

  build() {
    Scroll() {
      Column({ space: 5 }) {
        ForEach(this.btnList, (item: string, index: number) => {
          Button(item)
            .width('80%')
            .onClick(() => {
              this.onBtnClick(item)
            })
        })
      }
    }
    .width('100%')
    .height('100%')
  }

  onBtnClick(item: string) {
    console.info(`gravityAnalytics 点击了按钮：${item}`)
    if (item === "track") {
      GravityEngineSDK.track("testEvent", { "key1": "value1" });
    } else if (item === "getPresetProperties") {
      console.info(`gravityAnalytics getPresetProperties：${JSON.stringify(GravityEngineSDK.getPresetProperties())}`)
    } else if (item === "getDeviceId") {
      console.info(`gravityAnalytics getDeviceId：${GravityEngineSDK.getCurrentClientId()}`)
    } else if (item === "userDel") {
      GravityEngineSDK.userDelete();
    } else if (item === "userNumberMin") {
      GravityEngineSDK.userNumberMin({ "age": 0 });
    } else if (item === "userNumberMax") {
      GravityEngineSDK.userNumberMax({ "age": 10 });
    } else if (item === "clearSuperProperties") {
      GravityEngineSDK.clearSuperProperties();
    } else if (item === "unsetSuperProperty") {
      GravityEngineSDK.unsetSuperProperty("vipLevel");
    } else if (item === "flush") {
      GravityEngineSDK.flush();
    } else if (item === "userAppend") {
      GravityEngineSDK.userAppend({ "movies": ["Interstellar", "The Negro Motorist Green Book"] });
    } else if (item === "userUniqAppend") {
      GravityEngineSDK.userUniqAppend({ "movies": ["Interstellar", "The Negro Motorist Green Book"] });
    } else if (item === "userAdd") {
      GravityEngineSDK.userAdd({ "age": 1 });
    } else if (item === "userUnset") {
      GravityEngineSDK.userUnset("age");
    } else if (item === "getSuperProperties") {
      console.info(`gravityAnalytics getSuperProperties：${JSON.stringify(GravityEngineSDK.getSuperProperty())}`)
    } else if (item === "setSuperProperties") {
      GravityEngineSDK.setSuperProperties({ "vipLevel": 1 });
    } else if (item === "userSetOnce") {
      GravityEngineSDK.userSetOnce({ "$first_visit_time": Date.now() });
    } else if (item === "userSet") {
      GravityEngineSDK.userSet({ "$name": "test_name" });
    } else if (item === "adShowEvent") {
      GravityEngineSDK.trackAdShowEvent({
        adPlacementId: "placement_id",
        adSourceId: "ad_source_id",
        adUnionType: "topon",
        adType: "reward",
        adnType: "csj",
        ecpm: 1,
      });
    } else if (item === "timeEvent") {
      GravityEngineSDK.timeEvent("TestTimeEvent");
      GravityEngineSDK.track("TestTimeEvent", {});
    } else if (item === "initialize") {
      GravityEngineSDK.initialize({
        USER_CLIENT_NAME: 'your_client_name', // 用户昵称
        CHANNEL: "your_channel", // 用户初始化渠道
        ENABLE_SYNC_ATTRIBUTION: false // 是否开启同步获取归因信息，具体请参考https://doc.gravity-engine.com/turbo-integrated/sync_attribution.html
      }).then((res) => {
        console.log("gravityAnalytics initialize success ", JSON.stringify(res))
        GravityEngineSDK.updateUserInfo({
          "name":"testName-harmony",
          "channel":"testName-harmony",
          "version":312
        });
      }).catch((err: object) => {
        console.log("gravityAnalytics initialize failed error", JSON.stringify(err))
      });
    } else if (item === "payEvent") {
      const trace_id = GravityEngineSDK.trackPayEvent({
        payAmount: 300,
        payType: "CNY",
        orderId: "jHSGFtgaefgvygftFStydgyuhuyw005",
        payReason: "月卡",
        payMethod: "支付宝",
      });
      GravityEngineSDK.dryRunEventWithCallback(trace_id, { myDataKey: "myDataValue" }, {
        onFailed: (errorMsg: string): void => {
          console.log(
            "gravityAnalytics dryRunEventWithCallback onFailed error:", errorMsg
          );
        },
        onEmpty: (type: string): void => {
          //EMPTY_TYPE_NOT_ENABLE 没开启演练模式
          //EMPTY_TYPE_NO_IN_POSTBACK_WINDOW 不在窗口期
          //EMPTY_TYPE_SKIP 跳过
          console.log(
            "gravityAnalytics dryRunEventWithCallback onEmpty type:", type
          );
        },
        onTrackPay: (dryRunEventMediaType: string, payAmount: number, traceId: string, otherParams: object): void => {
          console.log(
            "gravityAnalytics dryRunEventWithCallback onTrackPay dryRunEventMediaType:" + dryRunEventMediaType +
              " payAmount:" + payAmount + " traceId:" + traceId + " otherParams:" + otherParams
          );
        },
        onTrackKeyActive: (dryRunEventMediaType: string, traceId: string, otherParams: object): void => {
          console.log(
            "gravityAnalytics dryRunEventWithCallback onTrackKeyActive dryRunEventMediaType:" + dryRunEventMediaType +
              " traceId:" + traceId + " otherParams:" + otherParams
          );
        }
      })
    }
  }

  onPageShow(): void {
    console.info('[testTag] ' + 'onPageShow')
    // hilog.info(0x0000, 'testTag', 'onPageShow onPageShow');
  }

  onPageHide(): void {
    hilog.info(0x0000, 'testTag', 'onPageHide onPageHide');
  }
}