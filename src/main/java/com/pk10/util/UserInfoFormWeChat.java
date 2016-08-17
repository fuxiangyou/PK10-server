package com.pk10.util;

import java.io.IOException;
import java.util.Date;

import org.apache.http.client.ClientProtocolException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.pk10.bean.TokenConfig;
import com.pk10.bean.UserInfo;
import com.pk10.control.UserInfoControl;
import com.sina.sae.fetchurl.SaeFetchurl;

/**
 * 从微信获取用户数据相关
 * 
 * @author Administrator
 *
 */
@Component
public class UserInfoFormWeChat {

	private static final Logger logger = LoggerFactory.getLogger(UserInfoFormWeChat.class);

	@Autowired
	private TokenConfig tokenConfig;

	public UserInfo getUserInfoFromWechat(String code) throws ClientProtocolException, IOException {
		String codeToOpenid = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + tokenConfig.getAppID() + "&secret=" + tokenConfig.getAppsecret() + "&code=" + code
				+ "&grant_type=authorization_code";
		// String userinfostr =
		// Request.Get(url).execute().returnContent().asString();
		SaeFetchurl fetchurl = new SaeFetchurl();
		String openidStr = fetchurl.fetch(codeToOpenid);
		logger.info("获取openid所用的URL ===> " + codeToOpenid);
		JSONObject openidInfo = JSON.parseObject(openidStr);
		logger.error("获取openid数据 ===>   " + openidStr);
		String getUserInfo = "https://api.weixin.qq.com/sns/userinfo?access_token=" + openidInfo.get("access_token") + "&openid=" + openidInfo.get("openid") + "&lang=zh_CN";
		String userinfo = fetchurl.fetch(getUserInfo);
		logger.error("获取用户信息 ===>" + userinfo);
		JSONObject userInfoObj = JSON.parseObject(userinfo);
		// TODO 需要解决读取乱码的问题
		return new UserInfo(userInfoObj.getString("openid"), userInfoObj.getString("nickname"), userInfoObj.getString("headimgurl"), null, new Date());
	}
}
