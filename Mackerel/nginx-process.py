#!/usr/bin/env python
# -*- encoding: utf-8 -*-
import os
import sys
import simplejson
 
def GraphDef():
    json_dic = {
        'graphs': {
            'process.count': {
                'label': 'Process Count',
                 'unit': 'integer',
                 'metrics': [
                     {
                        'name': 'nginx',
                        'label': 'Nginx'
                     }
                ]
            }
        }
    }
    print "# mackerel-agent-plugin"
    print simplejson.dumps(json_dic)
 
 
if __name__ == "__main__":
    if os.environ.get('MACKEREL_AGENT_PLUGIN_META', '')  == '1':
        GraphDef()
        sys.exit(0)
 
    os.system('/etc/mackerel-agent/scripts/nginx-process.sh')
