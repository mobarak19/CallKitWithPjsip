//
//  SIPconfig.swift
//  CallKitWithPjsipDemo
//
//  Created by Genusys Inc on 6/27/22.
//

import Foundation

class SipConfig{
    
    
    func sipReg(){

            var status: pj_status_t;
            status = pjsua_create();
            if (status != PJ_SUCCESS.rawValue) {
                NSLog("Failed creating pjsua");
            }

            /* Init configs */
            var cfg = pjsua_config();
            var log_cfg = pjsua_logging_config();
            var media_cfg = pjsua_media_config();
            pjsua_config_default(&cfg);
            pjsua_logging_config_default(&log_cfg);
            pjsua_media_config_default(&media_cfg);

            /* Initialize application callbacks */
            cfg.cb.on_call_state = on_call_state;
            cfg.cb.on_call_media_state = on_call_media_state;

            /* Init pjsua */
            status = pjsua_init(&cfg, &log_cfg, &media_cfg);
            
            /* Create transport */
            var transport_id = pjsua_transport_id();
            var tcp_cfg = pjsua_transport_config();
            pjsua_transport_config_default(&tcp_cfg);
            tcp_cfg.port = 5060;
            status = pjsua_transport_create(PJSIP_TRANSPORT_TCP,
                                            &tcp_cfg, &transport_id);

            /* Init account config */
            let id = strdup("Test<sip:test@pjsip.org>");
            let username = strdup("test");
            let passwd = strdup("pwd");
            let realm = strdup("*");
            let registrar = strdup("sip:pjsip.org");
            let proxy = strdup("sip:sip.pjsip.org;transport=tcp");

            var acc_cfg = pjsua_acc_config();
            pjsua_acc_config_default(&acc_cfg);
            acc_cfg.id = pj_str(id);
            acc_cfg.cred_count = 1;
            acc_cfg.cred_info.0.username = pj_str(username);
            acc_cfg.cred_info.0.realm = pj_str(realm);
            acc_cfg.cred_info.0.data = pj_str(passwd);
            acc_cfg.reg_uri = pj_str(registrar);
            acc_cfg.proxy_cnt = 1;
            acc_cfg.proxy.0 = pj_str(proxy);
            acc_cfg.vid_out_auto_transmit = pj_bool_t(PJ_TRUE.rawValue);
            acc_cfg.vid_in_auto_show = pj_bool_t(PJ_TRUE.rawValue);

            /* Add account */
            pjsua_acc_add(&acc_cfg, pj_bool_t(PJ_TRUE.rawValue), nil);

            /* Free strings */
            free(id); free(username); free(passwd); free(realm);
            free(registrar); free(proxy);
            
            /* Start pjsua */
            status = pjsua_start();
        
    }
}
