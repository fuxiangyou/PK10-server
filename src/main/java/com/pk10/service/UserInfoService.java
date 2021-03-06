package com.pk10.service;

import com.pk10.bean.AgentInfo;
import com.pk10.bean.Datagrid;
import com.pk10.bean.Page;
import com.pk10.bean.UserInfo;

import java.util.List;

public interface UserInfoService extends BaseService<UserInfo> {
	/**
	 * 用户兑奖操作
	 *
	 * @param userInfo
	 * @return
	 * @throws Exception
	 */
	public UserInfo cashPrize(UserInfo userInfo) throws Exception;

	/**
	 * 检测手机是否占用
	 * 
	 * @param userInfo
	 * @return
	 */
	UserInfo getUserInfoByTel(UserInfo userInfo);

	/**
	 * 检测用户名是否占用
	 * 
	 * @param userInfo
	 * @return
	 */
	UserInfo getUserInfoByUsername(UserInfo userInfo);

	/**
	 * 登录
	 * 
	 * @param userInfo
	 * @return
	 */
	public UserInfo login(UserInfo userInfo);

	/**
	 * 管理员登录
	 * 
	 * @param userInfo
	 * @return
	 */
	public UserInfo managerLogin(UserInfo userInfo);

	/**
	 * 查询所有代理商
	 * @return
	 */
	public Datagrid getAllAgent(Page page,AgentInfo agentInfo);

	/**
	 * 通过ID查询代理商
	 * @param agentInfo
	 * @return
	 */
	public AgentInfo getAgentById(AgentInfo agentInfo);

	/**
	 * 更新代理商信息
	 * @param agentInfo
	 * @return
	 */
	public Integer updateAgent(AgentInfo agentInfo);

	/**
	 * 添加代理商
	 * @param agentInfo
	 * @return
	 */
	public Integer savaAgent(AgentInfo agentInfo);

	/**
	 * 获取代理商名下所有用户
	 * @param userInfo
	 * @return
	 */
	public List<UserInfo> getUsersForAgent(UserInfo userInfo);

	List<UserInfo> getAgentsById(Integer id);

	List<UserInfo> getAgentsByOwnerId(Integer ownerId);

	List<UserInfo> getUsersByAgentId(String username, Integer isagent);

	public UserInfo getUserUsername(UserInfo userInfo);
}
