//Copyright 2015 Paul Tegelaar

//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.
package com.pte.liquid.camel;

import org.apache.camel.Processor;
import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.model.dataformat.JaxbDataFormat;
import org.springframework.stereotype.Component;

import com.pte.liquid.camel.processors.ConvertMessageJsonProcessor;


@Component
public class IndexLiquidMessageRoute extends RouteBuilder{	

	
    @Override
    public void configure() throws Exception {
    	JaxbDataFormat jaxb = new JaxbDataFormat();
    	Processor convertMessageJsonProcessor = new ConvertMessageJsonProcessor();
    	
    	jaxb.setContextPath("com.pte.liquid.relay.model");    	
    	from("jms:queue:com.pte.liquid.relay.in").unmarshal(jaxb).process(convertMessageJsonProcessor).to("elasticsearch://{{liquid.elastic.cluster.name}}?transportAddresses={{liquid.elastic.addresses}}&operation=INDEX&indexName={{liquid.elastic.index.name}}&indexType=liquid_elastic");
    }

}
