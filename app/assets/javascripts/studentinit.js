Ext.onReady(function() {
        Ext.create('Ext.container.Viewport', {
            layout: 'border',
            items: [{
                region: 'north',
                border: false,
                height: 24,
                tbar: [{
                    	text: '<marquee width="400px">欢迎访问</marquee>',
                },  '->',
				{
                    text: '选项',
                    iconCls: 'options_icon',
                    menu: [{
                        text: 'change yellow theme',
						handler: function(){
							Ext.util.CSS.swapStyleSheet('theme','/assets/extjs-yellow.css'); 
							Ext.Ajax.request({
								url: "http://"+document.location.href.split('/')[2]+'/application/settheme.json',
								params: { theme: 'extjs-yellow' },								
								success: function(response, opts){
									console.log('success');
								},
								failure: function(){
									console.log('failure');
								}
							}) 
						}
                    },{
                        text: 'change ping theme',
						handler: function(){
							 Ext.util.CSS.swapStyleSheet('theme','/assets/extjs-pink.css');  
							Ext.Ajax.request({
								url: "http://"+document.location.href.split('/')[2]+'/application/settheme.json',
								params: { theme: 'extjs-pink' },								
								success: function(response, opts){
									console.log('success');
								},
								failure: function(){
									console.log('failure');
								}
							}) 
						}
                    }, {
                        text: 'change default theme',
						handler: function(){
							 Ext.util.CSS.swapStyleSheet('theme','/assets/extjs-default.css');
							Ext.Ajax.request({
								url: "http://"+document.location.href.split('/')[2]+'/application/settheme.json',
								params: { theme: 'extjs-default' },								
								success: function(response, opts){
									console.log('success');
								},
								failure: function(){
									console.log('failure');
								}
							})   
						}
                    }, {
                        text: 'change chinese',
						handler: function(){
							Ext.Ajax.request({
								url: "http://"+document.location.href.split('/')[2]+'/application/setlanguage.json',
								params: { language: 'zh' },
								success: function(response, opts){
									console.log(Ext.decode(response.responseText).currenturl);
									window.location.href=Ext.decode(response.responseText).currenturl.replace(/.json/,'');
								},
								failure: function(){
									console.log('failure');
								}
							})
						}
                    }, {
                        text: 'change english',
						handler: function(){
							Ext.Ajax.request({
								url: "http://"+document.location.href.split('/')[2]+'/application/setlanguage.json',
								params: { language: 'en' },
								success: function(response, opts){
									console.log(Ext.decode(response.responseText).currenturl);
									window.location.href=Ext.decode(response.responseText).currenturl.replace(/.json/,'');
								},
								failure: function(){
									console.log('failure');
								}
							})
						}
                    }]
                }, {
                    text: '帮助'
                }, '-', {
                    text: '退出',
                    iconCls: 'logout',
                    handler : function ( b, e ) {
                      	Ext.Msg.confirm("", "确定退出?", function(e){if(e == 'yes'){
						 	Ext.Ajax.request({
	                   			url: "http://"+document.location.href.split('/')[2]+'/logout',
	                   			success: function(response, opts) {
	                       			window.location.href="http://"+document.location.href.split('/')[2]+'/login'
			                   },
			                   failure: function(response, opts) {
			                      console.log('server-side failure with status code ' + response.status);
			                   }
                			});
						}
						});
                  /*
                     Ext.MessageBox.show({
						    title:'Messagebox Title',
						    msg: 'Are you sure logout?',
						    buttonText: {yes: "Yes",no: "No"},
						    fn: function(btn){
                                Ext.Ajax.request({
                   					url: 'http://localhost:3000/logout',
                   					success: function(response, opts) {
                       					window.location.href="http://localhost:3000"
		                   			},
		                   			failure: function(response, opts) {
		                      			console.log('server-side failure with status code ' + response.status);
		                   			}
                					});
						        console.debug('you clicked: ',btn); //you clicked:  yes
						    }
						});
                  */
                     }
                }]
            }, {
                region: 'west',
                collapsible: true,
                split: true,
                id: 'left',
                title: '目录',
                width: 150,
                layout: 'accordion',
                items: [{
                    contentEl: 'historydata-management',
                    title:  '历史数据管理',
                    iconCls: 'first', // see the HEAD section for style used
                    autoScroll: true
                }, {
                    contentEl: 'personinfo-management',
                    title: '个人信息管理',
                    iconCls: 'second',
                    autoScroll: true
                },{
                    contentEl: 'datagraph-management',
                    title:  '运动趋势图',
                    iconCls: 'three', // see the HEAD section for style used
                    autoScroll: true
                }, {
                    contentEl: 'rank-management',
                    title: '个人排名',
                    iconCls: 'four',
                    autoScroll: true
                }, {
                    contentEl: 'feedback-management',
                    title: '运动建议',
                    iconCls: 'five',
                    autoScroll: true
                }
                ],
                // could use a TreePanel or AccordionLayout for navigational items
            }, {
                region: 'south',
                height: 26,
                /*
                bbar: [ // Bottom Bar
                    { xtype: 'button', text: 'Button 1' }
                ]
                */ 
				/*
                dockedItems: [{
                    xtype: 'toolbar',
                    dock: 'bottom',
                    items: [
                        {
                            xtype: 'button',
                            text: 'Show Warning & Clear',
                            handler: function (){
                                var sb = Ext.getCmp('basic-statusbar');
                                sb.setStatus({
                                    text: 'Oops!',
                                    iconCls: 'x-status-error',
                                    clear: true // auto-clear after a set interval
                                });
                            }
                        },
                        {
                            xtype: 'button',
                            text: 'Show Busy',
                            handler: function (){
                                var sb = Ext.getCmp('basic-statusbar');
                                // Set the status bar to show that something is processing:
                                sb.showBusy();
                            }
                        },
                        {
                            xtype: 'button',
                            text: 'Clear status',
                            handler: function (){
                                var sb = Ext.getCmp('basic-statusbar');
                                // once completed
                                sb.clearStatus();
                            }
                        },
                        '-',
                        'Plain Text'
                    ]
                }]
                 */
            }, {
                region: 'center',
                border:true,
                layout:"fit",
                id: 'center',
                items: [{
                    contentEl: 'main',
                    title: '',
                    autoScroll: true
                }]
            }]
        });
});  
