<#--
 *
 * Copyright 2018 datagear.tech
 *
 * Licensed under the LGPLv3 license:
 * http://www.gnu.org/licenses/lgpl-3.0.html
 *
-->
<#include "../include/page_import.ftl">
<#include "../include/html_doctype.ftl">
<html>
<head>
<#include "../include/html_head.ftl">
<title>
	<#include "../include/html_app_name_prefix.ftl">
	<@spring.message code='module.user' />
	<#include "../include/html_request_action_suffix.ftl">
</title>
</head>
<body class="p-card no-border">
<#include "../include/page_obj.ftl">
<div id="${pid}" class="page page-form horizontal">
	<form class="flex flex-column" :class="{readonly: isReadonlyAction}">
		<div class="page-form-content flex-grow-1 pr-2 py-1 overflow-y-auto">
			<div class="field grid">
				<label for="${pid}name" class="field-label col-12 mb-2 md:col-3 md:mb-0">
					<@spring.message code='username' />
				</label>
		        <div class="field-input col-12 md:col-9">
		        	<p-inputtext id="${pid}name" v-model="pm.name" type="text" class="input w-full"
		        		name="name" required maxlength="50" autofocus>
		        	</p-inputtext>
		        </div>
			</div>
			<div class="field grid" v-if="!isReadonlyAction">
				<label for="${pid}password" class="field-label col-12 mb-2 md:col-3 md:mb-0">
					<@spring.message code='password' />
				</label>
		        <div class="field-input col-12 md:col-9">
		        	<p-password id="${pid}password" v-model="pm.password" class="input w-full"
		        		input-class="w-full" toggle-mask :feedback="false"
		        		name="password" :required="isAddAction" maxlength="50" autocomplete="new-password">
		        	</p-password>
		        </div>
			</div>
			<div class="field grid" v-if="!isReadonlyAction">
				<label for="${pid}confirmPassword" class="field-label col-12 mb-2 md:col-3 md:mb-0">
					<@spring.message code='confirmPassword' />
				</label>
		        <div class="field-input col-12 md:col-9">
		        	<p-password id="${pid}confirmPassword" v-model="pm.confirmPassword" class="input w-full"
		        		input-class="w-full" toggle-mask :feedback="false"
		        		name="confirmPassword" :required="isAddAction" maxlength="50" autocomplete="new-password">
		        	</p-password>
		        </div>
			</div>
			<div class="field grid">
				<label for="${pid}realName" class="field-label col-12 mb-2 md:col-3 md:mb-0">
					<@spring.message code='realName' />
				</label>
		        <div class="field-input col-12 md:col-9">
		        	<p-inputtext id="${pid}realName" v-model="pm.realName" type="text" class="input w-full"
		        		name="realName" maxlength="50">
		        	</p-inputtext>
		        </div>
			</div>
			<div class="field grid" v-if="!disableRoles">
				<label for="${pid}roles" class="field-label col-12 mb-2 md:col-3 md:mb-0">
					<@spring.message code='module.role' />
				</label>
		        <div class="field-input col-12 md:col-9">
		        	<div class="p-inputgroup">
			        	<div id="${pid}roles" class="input p-inputtext w-full border-noround-right overflow-auto" style="height:6rem;">
			        		<p-chip v-for="role in pm.roles" :key="role.id" :label="role.name" class="mb-2" :removable="!isReadonlyAction" @remove="onRemoveRole($event, role.id)"></p-chip>
			        	</div>
			        	<p-button type="button" label="<@spring.message code='select' />"
			        		@click="onSelectRole" class="p-button-secondary"
			        		v-if="!isReadonlyAction">
			        	</p-button>
		        	</div>
		        </div>
			</div>
			<div class="field grid" v-if="isReadonlyAction">
				<label for="${pid}createTime" class="field-label col-12 mb-2 md:col-3 md:mb-0">
					<@spring.message code='createTime' />
				</label>
		        <div class="field-input col-12 md:col-9">
		        	<p-inputtext id="${pid}createTime" v-model="pm.createTime" type="text" class="input w-full"
		        		name="createTime" readonly="readonly">
		        	</p-inputtext>
		        </div>
			</div>
		</div>
		<div class="page-form-foot flex-grow-0 pt-3 text-center">
			<p-button type="submit" label="<@spring.message code='save' />"></p-button>
		</div>
	</form>
</div>
<#include "../include/page_form.ftl">
<script>
(function(po)
{
	po.submitUrl = "/user/"+po.submitAction;
	po.disableRoles = ("${(disableRoles!false)?string('true', 'false')}"  == "true");
	
	po.vueRef("disableRoles", po.disableRoles);
	
	var formModel = <@writeJson var=formModel />;
	po.setupForm(formModel, po.submitUrl, {}, function()
	{
		var options =
		{
			rules:
			{
				"confirmPassword":
				{
					"equalTo" : po.elementOfName("password")
				}
			}
		};
		
		return options;
	});
	
	po.vueMethod(
	{
		onRemoveRole: function(e, roleId)
		{
			var pm = po.vuePageModel();
			var roles = (pm.roles || []);
			$.removeById(roles, roleId);
		},
		
		onSelectRole: function()
		{
			po.handleOpenSelectAction("/role/select?multiple", function(roles)
			{
				var pm = po.vuePageModel();
				var pmRoles = (pm.roles || (pm.roles = []));
				$.addById(pmRoles, roles);
			});
		}
	});
	
	po.vueMount();
})
(${pid});
</script>
</body>
</html>