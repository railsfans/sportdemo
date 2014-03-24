Ext.onReady(function() {
//	 Ext.require('Ext.data.JsonP', function() {
		Ext.data.JsonP.request({
		    url : "http://api.wunderground.com/api/4ab310c7d75542f3/geolookup/conditions/q/IA/hangzhou.json",
		    success : function(parsed_json) {
		        var location = parsed_json['location']['city'];
		        var temp_c = parsed_json['current_observation']['temperature_string'];
				Ext.getCmp('weatherreport').setText("<marquee>杭州当前温度为" + temp_c+"</marquee>");
		        	return temp_c;
		    }
		});
//        });
		var reload = function() {
		  Ext.data.JsonP.request({
			    url : "http://api.wunderground.com/api/4ab310c7d75542f3/geolookup/conditions/q/IA/hangzhou.json",
			    success : function(parsed_json) {
			        var location = parsed_json['location']['city'];
			        var temp_c = parsed_json['current_observation']['temperature_string'];
					Ext.getCmp('weatherreport').setText("<marquee>杭州当前温度为" + temp_c+"</marquee>");
			        	return temp_c;
			    }
			});
		}
		setInterval(reload, 100000);

		var weatherBtn = Ext.create('Ext.button.Button', {
    //		text: '<marquee width="400px">欢迎访问</marquee>',
			id: 'weatherreport',
    		scope   : this,
    		handler : function() {
        
    		},
			listeners : {
    			click: function(button,event) {
        			button.setText('Hide');
    			}
			}
		});
        Ext.create('Ext.container.Viewport', {
            layout: 'border',
            items: [{
                region: 'north',
                border: false,
                height: 24,
                tbar: [weatherBtn,
				'->',
				{
                    text: '选项',
                    iconCls: 'options_icon',
                    menu: [{
                        text: 'User Info'
                    }, {
                        text: 'Settings'
                    }, {
                        text: 'Switch Theme'
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
                    title:  '手机管理',
                    iconCls: 'first', // see the HEAD section for style used
                    autoScroll: true
                }, {
                    contentEl: 'personinfo-management',
                    title: '基站管理',
                    iconCls: 'second',
                    autoScroll: true
                },{
                    contentEl: 'datagraph-management',
                    title:  '地图管理',
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
