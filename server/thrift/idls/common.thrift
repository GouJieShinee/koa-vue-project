namespace java com.zhe800.finagle.thrift.common
namespace rb thrifts.common

include "result.thrift"
include "express.thrift"
include "auth.thrift"
include "sendsms.thrift"

 /**
   * 传递的fromSource
   * 创建接口人:龚炎
   * 创建时间：2016年4月25日
   * 工单号：133762
   */
 struct OperationParam{
	 1:string fromSource,
	 2:i32 operatorType,	/* 操作人类型 1-买家 2-卖家 3-客服 4-系统 */
	 3:i32 operatorId,		/* 操作人id		*/
	 4:string operatorName	/* 操作人名称	*/
}

/*售后维权类型*/
enum SourceType{
	/*售后*/
	REFUND=1,
	/*维权*/
	COMPLAIN=2
}

struct AreaInfo {
	/*ID*/
	1:i32 id,
	/*区域名称*/
	2:string name,
	/*区域短名称*/
	3:string shortName,
	/*区域属性*/
	4:string property,
	/*邮政编码*/
	5:string postCode,
	/*区域名称拼音*/
	6:optional string pinyin,
	/*区域名称首字母*/
	7:optional string initial,
	/*省ID*/
	8:optional i32 provinceId,
	/*市ID*/             
	9:optional i32 cityId,
	/*区ID*/
	10:optional i32 countyId
}

struct Attribution {
	/*省ID*/
	1:i32 provinceId,
	/*省份名称*/
	2:string provinceName, 
	/*市ID*/                    
	3:i32 cityId,
	/*市命称*/
	4:string cityName,
	/*区ID*/
	5:optional i32 countyId,
	/*区命称*/
	6:optional string countyName,
	/*省份短命称*/
	7:optional string shortProvinceName,
	/*市短命称*/
	8:optional string shortCityName,
	/*区短命称*/
	9:optional string shortCountyName
}

struct AttributionOperator {
	1:i32 provinceId,

	/*省份名称*/
	2:string provinceName,                     
	3:i32 cityId,              
	4:string cityName,
	5:string operator
}

struct AttributionId {
	1:i32 provinceId,
	2:i32 cityId,
	3:i32 countyId
}


struct AreaInfoResult {
	1:result.Result result,
	2:optional list<AreaInfo> areaInfo
}


struct AttributionResult {
	1:result.Result result,
	2:optional Attribution areaInfo,
}

struct AttributionOperatorResult {
	1:result.Result result,
	2:optional AttributionOperator attributionOperator,
}

struct AttributionIdResult {
	1:result.Result result,
	2:optional AttributionId attributionId
}

/*查询条件*/
struct QueryConditions{
	 1:optional string provinceName,
	 2:optional string cityName,
	 3:optional string countyName
}
/*查询地址，返回json结果*/
struct AreaInfoJsonResult {
	1:result.Result result,
	2:string areaInfoJson
}
/*查询地址，返回md5结果*/
struct AllAreaInfoMD5Result {
	1:result.Result result,
	2:string md5
}

struct VerifyParams {
	1:i32 keyWordTypeCode
}

struct VerifyParamList {
	1:list<i32> keyWordTypeCodes
}

struct SenstiveWords {
	1:list<string> senstiveWordsList
}

struct SenstiveWordsVerifyResult {
	1:result.Result result,
	2:list<SenstiveWords> senstiveWordsList
}

struct ExpressAddressExamineConditions{
	/* 售后维权类型 */
	1:SourceType sourceType,
	/* 售后维权ID */
	2:i32 sourceId,
	/* 订单号 */
	3:string orderId,
	/*快递公司索引*/
	4:string expressIndex,
	/*快递号*/
	5:string expressNum,
	6:i32 operatorId,
	7:i32 operatorType,
	8:string operatorName,
	/*请求来源*/
	9:string fromSource
}

struct ExpressAddressExamineResult{
	1:result.Result result,
	/*
	* 虚假运单号的判断规则 
	* 优先级由高到低是：
	* 1买家账户是否为黑名单
	* 2运单号是否与其他的订单的运单号相同
	* 3买家退货运单号是否与卖家发货运单号相同
	* 4是否有物流
	* 5运单揽收时间是否早于同意退货时间
	* 6买家退货地址是否与订单发货地址一致
	* 7退货运单的签收地址是否与商家所给的退货地址一致
	*/
	2:i32 resultNum
}

/**
 * 延迟发货信息
 */
struct DeliverDelayRecord {
	/* 是否延迟发货: 0-否, 1-是 */
	1:i32 isDelay,
	/* 场景类型 1-对用户显示具体发货类型 2-对用户显示完成发货时间 */
	2:i32 type,
	/* 延迟原因 */
	3:string delayReason,
	/* 最晚发货时间 */
	4:string deliverLimitTime,
	/* 发货类型(顺延天数转换为小时数) */
	5:i32 delayHours,
	/* 延迟发货记录id */
	6:i32 recordId
}

/**
 * 计算最迟发货时间参数
 */
struct CalcDeliverLimitTimeParam {
	/* 默认发货类型(小时数) */
	1:i32 defaultDeliverLimitHours,
	/* 商家id */
	2:i32 sellerId,
	/* 参考时间点 */
	3:optional string referTime
	
}

/**
 * 计算最迟发货时间返回
 */
struct CalcDeliverLimitTimeResult {
	1:result.Result result,
	2:DeliverDelayRecord record
}

/**
 * 查询延迟发货信息返回
 */
struct QueryDeliverDelayRecordResult {
	1:result.Result result,
	2:list<DeliverDelayRecord> records
}

/**
 * 查询延迟发货设置参数
 */
struct DeliverDelayQueryParam {
	/* 延迟发货记录id */
	1:list<i32> recordIds
}

/**
 * 初始化ip地址参数
 */
struct InitIp2AddressParam {

}


/**
 * 字符合法性验证参数
 */
struct ValidityCheckParam {
	1:string checkContent,	/* 需要验证的内容 */
	2:string contentDesc	/* 验证内容描述，用于错误信息提示。如果为空则默认“输入项” */
}
/**
 * 活动类型
 */
struct CheapAmountTypeParam{
	1:string type,	/* 优惠类型 */
	2:string typeName, /*优惠类型名称*/
	3:string classify,	/* 优惠类型 */
	4:string classifyName, /*优惠类型名称*/
	5:i32 effective, /*0有效，1无效*/
	/*预算类型 1-现金 2-代金券 3-线下*/
	6:optional string budgetType,
	/*展示平台0-全部 1-预算 必传*/
	7:optional string showPlatform,/*展示平台*/
	/*优惠类型名称拼音*/
	8:optional string typeNamePy, 
	/*优惠类型名称拼音*/
	9:optional string classifyNamePy
}
/**
 * 平台优惠类型字典
 * 主类型与子类型设计
   主为type，子类型为classify， 每条记录既包括主又包括子类型。还有子类型时，主类型包含多个需要处理
   89	17	积分活动	jfhd	1	领券中心	lqzx	0	1	12010	2	1
 */
struct CheapAmountType {
	1:i32 id,	/* 主键 */
	2:i32 type,	/* 主优惠类型 */
	3:string typeName, /*主优惠类型名称*/
	4:i32 classify,	/* 子优惠类型 */
	5:string classifyName, /*子优惠类型名称*/
	6:i32 effective, /*0有效，1无效*/
	7:optional string classifyNamePy,/*子优惠类型名称拼音*/ 
	8:optional string typeNamePy,/*主优惠类型名称拼音*/ 
	9:optional string showPlatform, /*展示平台 1-预算码使用，其他应用暂不关注次字段*/ 
	10:optional i32 showSort,/*展示顺序*/ 
	11:optional i32 budgetType,/*预算类型 1-现金 2-代金券 3-线下*/
	12:optional i32 hasChild/*是否包含子类型 1包含 2不包含*/ 
}
/**
 * 计算最迟发货时间返回
 */
struct CheapAmountTypeResult {
	1:result.Result result,
	2:list<CheapAmountType> cheapAmountTypes
}

/**********************************************************************************************/
/**************************  迁移advertisement.thrift文件结构体 start  ************************/
/* 广告状态*/
enum AdvertisementStateEnum {
	/* 未使用*/
	READY=1,
	/* 使用中*/
	USING=2
}

/* 广告类型*/
enum AdvertisementTypeEnum {
	/* 商品详情页中部固定广告*/
	PRODUCT_DETAIL_MIDDLE_FIXED_AD=1,
	/* 商品详情页右侧悬浮广告*/
	PRODUCT_DETAIL_RIGHT_SUSPEND_AD=2,
	/* 订单列表页顶部广告*/
	ORDER_LIST_TOP_AD=3,
	/* 订单列表页底部广告*/
	ORDER_LIST_BOTTOM_AD=4,
	/* 商品详情页便利贴广告*/
	PRODUCT_DETAIL_STICKY_NOTE_AD=5,
	/* 支付成功页中部广告*/
	PAY_SUCCESS_MIDDLE_AD=6,
	/* 商品详情页大促广告*/
	PRODUCT_DETAIL_PROMOTION_AD=7
}

struct AdvertisementInfo {
	1:i32 id,                                  			/*广告Id*/
	2:string title,              						/*广告标题*/
	3:i32 weight,                						/*权重*/
	4:string startTime,          						/*广告播出开始时间*/
	5:string endTime,            						/*广告播出结束时间*/
	6:string linkUrl,            						/*链接地址*/
	7:string imgKey,             						/*图片名 宽*/
	8:AdvertisementStateEnum advertisementStateEnum,  	/*广告状态*/
	9:i32 subjectId,             						/*类目ID*/
	10:AdvertisementTypeEnum advertisementTypeEnum,		/*广告类型*/ 
	11:string createTime,								/*创建时间*/
	12:string updateTime,								/*更新时间*/
	13:string imgKey_narrow            						/*图片名 窄*/
}

struct AdvertisementInfoResult {
	1:result.Result result,
	2:AdvertisementInfo advertisementInfo;
}

struct QueryAdvertisementConditionWithPagination {
	1:list<AdvertisementTypeEnum> advertisementTypeEnumList,
	2:AdvertisementStateEnum advertisementStateEnum,
	3:string title,
	4:i32 numPerPage, 
	5:i32 currentPage
}

struct AdvertisementInfoListResult {
	1:result.Result result,
	2:i32 total,
	3:list<AdvertisementInfo> advertisementInfoList 
}

struct AdvertisementvailableListResult {
	1:result.Result result,
	2:list<AdvertisementInfo> advertisementInfoList     
}
/**************************  迁移advertisement.thrift文件结构体 end  **************************/
/**********************************************************************************************/

/**********************************************************************************************/
/***************************  迁移sellerGuestbook.thrift结构体 start  *************************/
struct SellerGuestbook{ 
	/*主键Id*/
	1:i32 id,
	/*卖家Id*/
	2:i32 sellerId,
	/*卖家昵称*/
	3:string sellerNickname,
	/*电话*/
	4:string phone,
	/*处理状态 1:待处理(新) 2:暂不处理 10:已处理*/
	5:i16 state,
	/*创建时间*/
	6:string createAt,
	/*类型  1:意见   2:问题*/
	7:i16 type,
	/*处理时间*/
	8:string handleTime,
	/*处理人*/
	9:string handlePeople,
	/*内容*/
	10:string content,
	/*处理结果  1:忽略  2:分派*/
	11:i16 handleResult,
	/*主账户*/
	12:string account,
	/*子账户*/
	13:string child_account,
	/*商家旺旺*/
	14:string sellerWangwang
}

struct SellerGuestbookResult{
	1:result.Result result,
	2:optional SellerGuestbook sellerGuestbook
}




struct SellerGuestbookResultByParam{
	1:result.Result result,
	2:optional list<SellerGuestbook> sellerGuestbooks
}


/*卖家中心查询条件*/
struct OpQueryCondition{
	/*卖家昵称*/
	1:string sellerNickname,
	/*类型  1:意见   2:问题*/
	2:i16 type,
	/*内容*/
	3:string content,
	/*创建起始时间*/
	4:string createAtStart,
	/*创建结束时间*/
	5:string createAtEnd,
	/*处理状态  99:待处理(包含1和2)  1:待处理(新) 2:暂不处理 10:已处理*/
	6:i16 state,
	/*处理结果  0:全部(包含1和2)  1:忽略  2:分派*/
	7:i16 handleResult,
	/*处理起始时间*/
	8:string handleTimeStart,
	/*处理结束时间*/
	9:string handleTimeEnd,
	/*当前页码*/
	10:i32 page,
	/*每页数量*/
	11:i32 perPage
}

struct OpQueryPaginate{
	/*总数量*/
	1:i32 total,
	/*总页数*/
	2:i32 pageCount,
	/*第几页*/
	3:i32 page,
	/*每页数量*/
	4:i32 perPage,
	5:optional list<SellerGuestbook> sellerGuestbooks 
}

struct OpQueryCollection{
	1:result.Result result,
	2:optional OpQueryPaginate opQueryPaginate
}
struct GuestbookCount{
	/*待处理的数量*/
	1:i32 handling,
	/*已处理的数量*/
	2:i32 handled
}

struct GuestbookCountResult{
	1:result.Result result,
	2:optional GuestbookCount guestbookCount
}


enum SellerGuestbookQueryType{

	findById=15001,
	findBySellerId=15002,
	findBysellerNickname=15003,
	findByPhone=15004,
	findByState=15005,
	findByCreateAt=15006,
	findByType=15007,
	findByHandleTime=15008,
	findByHandlePeople=15009,
	findByContent=15110,
	findByHandleResult=15111,
	findByAccount=15112,
	findByChildAccount=15113


}

struct ExportResult{
	1:result.Result result,
	2:optional list<SellerGuestbook> sellerGuestbooks
}
/***************************  迁移sellerGuestbook.thrift结构体 end    *************************/
/**********************************************************************************************/

service CommonServ {
	/*获取省份信息 不含港澳台*/
	AreaInfoResult province()               
	
	/*获取省份的市区信息 不含港澳台*/
	AreaInfoResult city(1:i32 provinceId) 
	
	/*获取省份的市区的县级信息 不含港澳台*/
	AreaInfoResult county(1:i32 cityId) 
	
	/*获取街道信息*/
	AreaInfoResult street(1:i32 county) 

	/* 根据手机号获取归属地 */
	AttributionResult numberAttribution(1: string number)

	/* 根据手机号获取归属地，带操作人 */
	AttributionOperatorResult numberAttributionOperator(1: string number)

	AttributionResult ipAttribution(1: string ip)

	AttributionResult cityAttribution(1: i32 cityId)

	AttributionIdResult idByName(1:string provinceName, 2:string cityName, 3:string countyName)

	/*根据区县ID，查找到省ID和市ID*/
	AttributionIdResult getAttributionIdByCountyId(1:i32 countyId)

	/*根据省市区ID，查找到省市区name.
	规则:查询county信息，则上级的省市ID为必填，同理查询city信息，则上级的省ID为必填.如果只查询省信息，则可以只传省ID
	*/
	AttributionResult getAttributionNameById(1:i32 provinceId,2:i32 cityId,3:i32 countyId)

	/*查询所有地址信息，返回AreaInfo对象的json串*/
	AreaInfoJsonResult queryAllAreaInfo(1:QueryConditions conditions)
	
	/*获取当前所有地址的md5值*/
	AllAreaInfoMD5Result getAllAreaInfoMD5()
	
	/*
	* 此接口已经弃用。请使用下面的接口，谢谢。兼容接口调用的时候 默认查第一层级的敏感词
	*/
	SenstiveWordsVerifyResult senstiveWordsVerify(1:list<string> sentences)
	
	/*
	* 校验多个句子中的关键词， 根据传参中关键词类型(VerifyParams.keyWordTypeCode)，返回每个对应句子中包含的全部关键词,
	* sentences不可为空， 且长度不可超过200，
	* VerifyParams.keyWordTypeCode i32类型枚举，1-敏感词；2-弱敏感词；3-违禁词。 4- 图片弱敏感词
	* 因工单 178876需要，将对应的商品敏感词分为两级。
	* 第一级（101）包含：1-敏感词 3-违禁词 还有 新添加的网络禁用敏感词
	* 第二级（102）包含：2-弱敏感词 4-图片弱敏感词
	* 之前传送的1 2 3 4 将会弃用
	*
	* 使用101 代替第一层级
	* 使用102 代替第二层级
	*/
	SenstiveWordsVerifyResult keyWordsVerify(1:list<string> sentences, 2:VerifyParams vParams)

	/*
	* 一次调用需要多个层级校验敏感词，例如图片需要1层级2层级均进行校验,调用此接口，list中传入多个层级
	* 178876需要，将对应的商品敏感词分为两级。
	* 使用101 代替第一层级
	* 使用102 代替第二层级
	*/
	SenstiveWordsVerifyResult keyWordsVerifyLevels(1:list<string> sentences, 2:VerifyParamList verifyParamList)
	
	
	/*获取全部市区信息
	* 拼团使用 
	* 调用者需要做本地缓存
	*/
	AreaInfoResult allCity(OperationParam operator)
	
	/*根据条件查询地址信息
	* 拼团使用 
	*/
	AreaInfoResult queryAreaByName(QueryConditions query, OperationParam operator)

	/*
	* 虚假运单号的判断规则 
	* 优先级由高到低是：
	* 1买家账户是否为黑名单
	* 2运单号是否与其他的订单的运单号相同
	* 3买家退货运单号是否与卖家发货运单号相同
	* 4是否有物流
	* 5运单揽收时间是否早于同意退货时间
	* 6买家退货地址是否与订单发货地址一致
	* 7退货运单的签收地址是否与商家所给的退货地址一致
	*/
	ExpressAddressExamineResult expressAddressExamine(1:ExpressAddressExamineConditions conditions);
	
	/**
	  * 计算最晚发货时间
	  * 创建接口人:苏石
	  * 接口使用者:商品服务、订单服务
	  * 创建时间：2016年7月29日
	  * 是否兼容老接口：新接口
	  * 工单号：167598
	  */
	CalcDeliverLimitTimeResult calcDeliverLimitTime(1:CalcDeliverLimitTimeParam calcParam, 2:OperationParam operator);
	
	/**
	  * 单条查询发货延迟设置信息
	  * 创建接口人:苏石
	  * 接口使用者:订单服务
	  * 创建时间：2016年7月29日
	  * 是否兼容老接口：新接口
	  * 工单号：167598
	  */
	QueryDeliverDelayRecordResult queryDeliverDelayRecord(1:DeliverDelayQueryParam queryParam, 2:OperationParam operator);

	/**
	 * 验证字符合法性（单条验证）
	 * 创建接口人:刘敏
	 * 接口使用者: 字符非法性验证需求方（java内部服务、买家中心、卖家中心、管理中心）
	 * 创建时间：2016-8-23
	 * 是否兼容老接口：新接口
	 * 工单号：179520
	 * 说明：operationInfo不能为空；operationInfo.operatorType不能为空；operationInfo.fromSource不能为空
	 */
	result.Result checkValueValidity(1:OperationParam operationInfo, 2:ValidityCheckParam checkContent);
		
	/**
	  * 重新初始化数据库的ip地址
	  * 创建接口人:赵连和
	  * 接口使用者:无
	  * 创建时间：2016年8月16日
	  * 是否兼容老接口：新接口
	  * 工单号：178010
	  */
	result.Result initIp2Address(1:InitIp2AddressParam queryParam, 2:OperationParam operator);

	/**
	 * 获取仓储省份信息  含港澳台
	 * 创建接口人:孙亚东
	 * 接口使用者: 李素娟  无线 招商
	 * 创建时间：2016年9月10日
	 * 是否兼容老接口：新接口
	 * 工单号：186872
	 */
	AreaInfoResult storageProvince()               
	
	/**
	 * 获取仓储省份的市区信息  含港澳台
	 * 创建接口人:孙亚东
	 * 接口使用者: 李素娟  无线 招商
	 * 创建时间：2016年9月10日
	 * 是否兼容老接口：新接口
	 * 工单号：186872
	 */
	AreaInfoResult storageCity(1:i32 provinceId) 
	
	/**
	 * 获取仓储省份的市区的县级信息  含港澳台
	 * 创建接口人:孙亚东
	 * 接口使用者: 李素娟  无线 招商
	 * 创建时间：2016年9月10日
	 * 是否兼容老接口：新接口
	 * 工单号：186872
	 */
	AreaInfoResult storageCounty(1:i32 cityId) 

	/**
	 * 获取优惠类型字典表
	 * 创建接口人:孙亚东
	 * 接口使用者: 程文超
	 * 创建时间：2016年10月19日
	 * 是否兼容老接口：新接口
	 * 工单号：197014
	 * 此接口只能查询预算类型为现金类型的类型，即budgetType=1查询全部美容使用getCheapAmountTypesByParam接口
	 */
	CheapAmountTypeResult getCheapAmountTypes();

	/**
	 * 根据展示获取优惠类型字典表（null获取全部数据）
	 * 创建时间：2016年11月03日
	 * 是否兼容老接口：新接口 
	 
	 * 此接口只能查询预算类型为现金类型的类型,即budgetType=1查询全部美容使用getCheapAmountTypesByParam接口
	 */
	CheapAmountTypeResult getCheapAmountTypesByShowPlatform(1:string showPlatform);

	/**
	 * 根据展示获取优惠类型字典表
	 * 创建时间：2017年5月02日
	 * 是否兼容老接口：新接口
	 */
	CheapAmountTypeResult getCheapAmountTypesByParam(1:CheapAmountTypeParam param);

/* ****************************  迁移advertisement.thrift接口 start  ************************** */
	/* 新建广告*/
	AdvertisementInfoResult addAdvertisement(1:AdvertisementInfo advertisementInfo);
	
	/* 编辑广告 */
	result.Result updateAdvertisement(1:AdvertisementInfo advertisementInfo);

	/* 删除广告 */
	result.Result delAdvertisement(1:i32 id);

	/* 查询广告（带分页）*/
	AdvertisementInfoListResult queryAdvertisement(1:QueryAdvertisementConditionWithPagination condition);
	
	/* 按主键（广告id）查询广告记录 */
	AdvertisementInfoResult getAdvertisementById(1:i32 id);

	/* 查询当前可用的广告记录 */
	AdvertisementvailableListResult queryValidAdvertisements();
/* ****************************  迁移advertisement.thrift接口 end    ************************** */

/* ****************************  迁移sellerGuestbook.thrift接口 start  ************************ */
	/*FailDesc("sellerId","1238902","商家id不能为空")*/
	/*FailDesc("content","1238904","描述不能为空")*/
	/*FailDesc("content","1238905","描述长度不合规")*/
	/*FailDesc("phone","1238906","电话不能为空")*/
	/*FailDesc("type", "1238910", "类型不能为空")*/
	/*FailDesc("type","1238911","类型错误")*/
	/*FailDesc("system","1238900","系统异常")*/
	/*添加接口*/
	SellerGuestbookResult apply(1:SellerGuestbook sellerGuestbook);
	
	/*FailDesc("id","1238901","id不能为空")*/
	/*FailDesc("sellerId","1238902","商家id不能为空")*/
	/*FailDesc("content","1238904","描述不能为空")*/
	/*FailDesc("content","1238905","描述长度不合规")*/
	/*FailDesc("phone","1238906","电话不能为空")*/
	/*FailDesc("type", "1238910", "类型不能为空")*/
	/*FailDesc("type","1238911","类型错误")*/
	/*FailDesc("system","1238900","系统异常")*/
	/*更新接口*/
	SellerGuestbookResult update(1:SellerGuestbook sellerGuestbook);
	
	/*FailDesc("state","1238908","处理状态不能为空")*/
	/*FailDesc("state","1238909","处理状态类型错误")*/
	/*FailDesc("system","1238900","系统异常")*/
	/*管理中心查询接口--根据搜索条件*/
	OpQueryCollection opQuery(1:OpQueryCondition condition);
	
	/*FailDesc("id","1238901","id不能为空")*/
	/*FailDesc("system","1238900","系统异常")*/
	/*查询接口--根据主键Id*/
	SellerGuestbookResult queryById(1:i32 id);
	
	/*管理中心--统计数量*/
	GuestbookCountResult countQuery();

	/*多条件查询*/
	SellerGuestbookResultByParam queryByParams(1:list<SellerGuestbookQueryType> queryTypes,2:SellerGuestbook sellerGuestbook);

	/*FailDesc("state","1238908","处理状态不能为空")*/
	/*FailDesc("state","1238909","处理状态类型错误")*/
	/*FailDesc("system","1238900","系统异常")*/
	/*管理中心导出接口--根据搜索条件--做多导出1W条数据*/
	ExportResult exportByCondition(1:OpQueryCondition condition);
/* ****************************  迁移sellerGuestbook.thrift接口 end    ************************ */


/* ****************************  迁移express.thrift接口 start    ************************ */
	result.StringResult addExpress(1:express.ExpressInfo info);
    result.Result updateExpress(1:express.ExpressInfo info);
    result.Result deleteExpress(1:i32 id);
    /*查询所有物流，提供下拉列表使用*/
	express.ExpressInfoResult query();
	express.ExpressInfo queryByIdExpress(1:i32 id);
	express.ExpressInfoResult queryByIdV1Express(1:i32 id);
	/*按卖家查询*/
	express.ExpressInfoResult queryBySeller(1:i32 sellerId);
	/*综合查询*/
	express.ExpressInfoPaginate queryByConditions(1:express.ExpressQueryConditions conditions);
    /*批量查询物流*/
	express.ExpressInfoResult queryBatch(1:list<i32> idList);
	/*查询货运物流*/
    express.ExpressInfoResult queryFreight();
	/*查询所有物流，原query()接口*/
	express.ExpressInfoResult queryEx();

	/*启用停用*/
	result.Result updateStatus(1:i32 id, 2:i32 status);

	/*
	 * 校验运单号是否合法
	 * validateRet=1 有效运单号
	 * validateRet=2 无效运单号
	 */
	result.StringResult validateExpressNo(1:express.ValidateExpressNoParams params);

	/*
	 * 查询 物流  id
	 * 这个对应 命令  zrange express:prefix:X  0  -1    这个X 由使用方来控制
	 */
	express.ExpressFilterResult expressFilterByPrefixName(1:express.ExpressFilterParam param);

/* ****************************  迁移express.thrift接口 end    ************************ */
/* ****************************  迁移auth.thrift接口 start    ************************ */
/*
	 *  校验当前用户的信息（身份证和姓名是否对应）
	 *  创建接口人: 龚炎
	 *  接口使用者:
	 *  创建时间：2016年6月12日
	 *  是否兼容老接口：新接口
	 *  工单：154752
	 *
	 *  因为调用第三方进行验证的时候回出现错误，错误编码 以 第三方的错误编码为准
	 *  http://www.haoservice.com/docs/65 如下
	 *  如果出现更多的错误编码 ， 会及时更新到 thrift文件。 并且进行通知
	 */
	result.Result authIdentityInfo(1:auth.UserAuthParam userAuthParam,2:auth.OperationInfo operationInfo);


	/*
	 *  下单校验（或回显信息）并且获取当前用户的身份证号码
	 *  创建接口人: 龚炎
	 *  接口使用者:
	 *  创建时间：2016年6月12日
	 *  是否兼容老接口：新接口
	 *  工单：154752
	 */
	auth.VerifiyInfoResult verifiyIdentityInfo(1:auth.VerifiyInfoParam verifiyInfoParam,2:auth.OperationInfo operationInfo);
/* ****************************  迁移auth.thrift接口 end      ************************ */
/* ****************************  迁移sendsms.thrift接口 start    ************************ */
	result.Result sendSMS(1:list<sendsms.SmsInfo> listSmsInfo);
/* ****************************  迁移sendsms.thrift接口 end    ************************ */
}