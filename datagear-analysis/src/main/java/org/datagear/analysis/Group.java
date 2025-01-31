/*
 * Copyright 2018 datagear.tech
 *
 * Licensed under the LGPLv3 license:
 * http://www.gnu.org/licenses/lgpl-3.0.html
 */

package org.datagear.analysis;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.datagear.util.i18n.AbstractLabeled;
import org.datagear.util.i18n.LabelUtil;
import org.datagear.util.i18n.Labeled;

/**
 * 分组。
 * <p>
 * 用于描述实体所属的分组信息。
 * </p>
 * <p>
 * 目前，此类主要用于{@linkplain ChartPluginAttribute#getGroup()}，没有直接采用{@linkplain Category}的原因是：
 * 都用于{@linkplain ChartPlugin}，容易引起混淆。
 * </p>
 * 
 * @author datagear@163.com
 *
 */
public class Group extends AbstractLabeled implements Serializable, NameAware
{
	private static final long serialVersionUID = 1L;
	
	public static final String PROPERTY_NAME = "name";
	public static final String PROPERTY_NAME_LABEL = Labeled.PROPERTY_NAME_LABEL;
	public static final String PROPERTY_DESC_LABEL = Labeled.PROPERTY_DESC_LABEL;
	public static final String PROPERTY_ORDER = "order";

	private String name;

	private int order = 0;

	public Group()
	{
		super();
	}

	public Group(String name)
	{
		super();
		this.name = name;
	}

	@Override
	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public int getOrder()
	{
		return order;
	}

	public void setOrder(int order)
	{
		this.order = order;
	}

	/**
	 * 复制为指定{@linkplain Locale}的对象。
	 * 
	 * @param locale
	 * @return
	 */
	public Group clone(Locale locale)
	{
		Group target = new Group(this.name);
		target.setOrder(this.order);
		LabelUtil.concrete(this, target, locale);

		return target;
	}

	@Override
	public String toString()
	{
		return getClass().getSimpleName() + " [name=" + name + ", nameLabel=" + getNameLabel() + ", descLabel="
				+ getDescLabel() + ", order=" + order + "]";
	}

	/**
	 * 复制为指定{@linkplain Locale}的对象。
	 * 
	 * @param categories
	 * @param locale
	 * @return
	 */
	public static List<Group> clone(List<Group> categories, Locale locale)
	{
		if (categories == null)
			return null;

		List<Group> re = new ArrayList<Group>(categories.size());

		for (Group category : categories)
			re.add(category.clone(locale));

		return re;
	}
}
