Ext.onReady(function() {
        Ext.create('Ext.container.Viewport', {
            layout: 'border',
            items: [{
                region: 'north',
                border: false,
                height: 24,
                tbar: [{
                    	text: '<marquee width="400px">welcome to here</marquee>',
                },  '->',
				{
                    text: 'Options',
                    iconCls: 'options_icon',
                    menu: [{
                        text: 'User Info'
                    }, {
                        text: 'Settings'
                    }, {
                        text: 'Switch Theme'
                    }]
                }, {
                    text: 'Help'
                }, '-', {
                    text: 'Logout',
                    iconCls: 'logout',
                    handler : function ( b, e ) {
                      	Ext.Msg.confirm("Messagebox Title", "Are you sure logout?", function(e){if(e == 'yes'){
						 	Ext.Ajax.request({
                   			url: 'http://localhost:3000/logout',
                   			success: function(response, opts) {
                       			window.location.href="http://localhost:3000/login"
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
                title: 'Navigation',
                width: 150,
                layout: 'accordion',
                items: [{
                    contentEl: 'historydata-management',
                    title:  '班级管理',
                    iconCls: 'first', // see the HEAD section for style used
                    autoScroll: true
                }, {
                    contentEl: 'personinfo-management',
                    title: '学期管理',
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
