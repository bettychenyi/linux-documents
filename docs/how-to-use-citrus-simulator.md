# Citrus Simulator

## Installation
* I used ```Ubuntu 1804``` environment.
* Need to install ```JDK 1.8+``` and ```Maven 3.6+```

Please refer to ```how-to-use-citrus-samples.md``` for more infomation about this.

## Install and configure Citrus Simulator with the default samples

```
git clone https://github.com/citrusframework/citrus-simulator
cd citrus-simulator
mvn install spring-boot:run
```

In this step, it may compliant the Spring Agent has some configuration problems.
```
[ERROR] No plugin found for prefix 'spring-boot' in the current project and in the plugin groups
```
Then let's define this plugin in the ```pom.xml```:
```
  <build>
    <pluginManagement>
      <plugins>
        <plugin>
        ... Other Plugin Definations ...
        </plugin>
      </plugins>
    </pluginManagement>

    <plugin>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-maven-plugin</artifactId>
        <dependencies>
            <dependency>
                <groupId>org.springframework</groupId>
                <artifactId>springloaded</artifactId>
                <version>1.2.1.RELEASE</version>
            </dependency>
        </dependencies>
      </plugin>
    </plugins>
    
    ....
```    
    
If you still see errors, then run 
```
mvn clean install
```

You may see errors like :
```
Error: Exception thrown by the agent : java.rmi.server.ExportException: Port already in use: 9001; nested exception i                                                                                                                        
```

But some of the projects will be install successfully, like below:

```
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary for citrus-simulator 1.1.0-SNAPSHOT:
[INFO]
[INFO] citrus-simulator ................................... SUCCESS [  0.898 s]
[INFO] citrus-simulator-starter ........................... SUCCESS [ 10.806 s]
[INFO] citrus-simulator-ui ................................ SUCCESS [01:20 min]
[INFO] citrus-simulator-docs .............................. SUCCESS [  0.037 s]
[INFO] citrus-simulator-samples ........................... SUCCESS [  0.013 s]
[INFO] citrus-simulator-sample-bank-service ............... SUCCESS [ 20.410 s]
[INFO] citrus-simulator-sample-rest ....................... SUCCESS [ 17.647 s]
[INFO] citrus-simulator-sample-ws ......................... SUCCESS [ 16.152 s]
[INFO] citrus-simulator-sample-ws-client .................. FAILURE [01:03 min]
[INFO] citrus-simulator-sample-wsdl ....................... SKIPPED
[INFO] citrus-simulator-sample-mail ....................... SKIPPED
[INFO] citrus-simulator-sample-combined ................... SKIPPED
[INFO] citrus-simulator-sample-jms ........................ SKIPPED
[INFO] citrus-simulator-sample-jms-fax .................... SKIPPED
[INFO] citrus-simulator-archetypes ........................ SKIPPED
[INFO] citrus-simulator-archetype-rest .................... SKIPPED
[INFO] citrus-simulator-archetype-swagger ................. SKIPPED
[INFO] citrus-simulator-archetype-ws ...................... SKIPPED
[INFO] citrus-simulator-archetype-wsdl .................... SKIPPED
[INFO] citrus-simulator-archetype-jms ..................... SKIPPED
[INFO] citrus-simulator-archetype-mail .................... SKIPPED
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  03:30 min
[INFO] Finished at: 2019-01-16T07:49:34Z
[INFO] ------------------------------------------------------------------------
[ERROR] Failed to execute goal org.springframework.boot:spring-boot-maven-plugin:2.0.4.RELEASE:start (pre-integration                                                                                                                        -test) on project citrus-simulator-sample-ws-client: Could not figure out if the application has started: Failed to c                                                                                                                        onnect to MBean server at port 9001: Spring application did not start before the configured timeout (60000ms -> [Help                                                                                                                         1]

```

Then that would be fine now. Let's try to bring up the ```SOAP``` (ws) sample simulator.
```
mvn -pl simulator-samples/sample-ws spring-boot:run
```
This sample simulator is defined here:

https://github.com/citrusframework/citrus-simulator/tree/master/simulator-samples/sample-ws.

The above link contains a good introduction to this ```SOAP``` Web service (the so-called "ws") Simulator.
Based on the introduction, we also can run this with:
```
cd citrus-simulator/simulator-samples/sample-ws/
mvn clean install
mvn spring-boot:run
```

Anyway, after run that, we will see the citrus simulator console will print:
```
2019-01-16 08:32:26.034  INFO 31499 --- [           main] mulatorWebServiceConfigurationProperties : Using the simulator configuration: SimulatorWebServiceConfigurationProperties{enabled='true', servletMapping='/services/ws/*'}
2019-01-16 08:32:26.456  INFO 31499 --- [           main] o.s.s.c.ThreadPoolTaskScheduler          : Initializing ExecutorService  'taskScheduler'
2019-01-16 08:32:26.638  INFO 31499 --- [           main] o.s.b.a.e.web.EndpointLinksResolver      : Exposing 2 endpoint(s) beneath base path '/actuator'
2019-01-16 08:32:26.650  INFO 31499 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/health],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
2019-01-16 08:32:26.650  INFO 31499 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator/info],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto public java.lang.Object org.springframework.boot.actuate.endpoint.web.servlet.AbstractWebMvcEndpointHandlerMapping$OperationHandler.handle(javax.servlet.http.HttpServletRequest,java.util.Map<java.lang.String, java.lang.String>)
2019-01-16 08:32:26.651  INFO 31499 --- [           main] s.b.a.e.w.s.WebMvcEndpointHandlerMapping : Mapped "{[/actuator],methods=[GET],produces=[application/vnd.spring-boot.actuator.v2+json || application/json]}" onto protected java.util.Map<java.lang.String, java.util.Map<java.lang.String, org.springframework.boot.actuate.endpoint.web.Link>> org.springframework.boot.actuate.endpoint.web.servlet.WebMvcEndpointHandlerMapping.links(javax.servlet.http.HttpServletRequest,javax.servlet.http.HttpServletResponse)
2019-01-16 08:32:26.795  INFO 31499 --- [           main] o.s.j.e.a.AnnotationMBeanExporter        : Registering beans for JMX exposure on startup
2019-01-16 08:32:26.798  INFO 31499 --- [           main] o.s.j.e.a.AnnotationMBeanExporter        : Bean with name 'dataSource' has been autodetected for JMX exposure
2019-01-16 08:32:26.807  INFO 31499 --- [           main] o.s.j.e.a.AnnotationMBeanExporter        : Located MBean 'dataSource': registering with JMX server as MBean [com.zaxxer.hikari:name=dataSource,type=HikariDataSource]
2019-01-16 08:32:26.829  INFO 31499 --- [           main] o.s.c.support.DefaultLifecycleProcessor  : Starting beans in phase 0
2019-01-16 08:32:26.829  INFO 31499 --- [           main] o.s.i.endpoint.EventDrivenConsumer       : Adding {logging-channel-adapter:_org.springframework.integration.errorLogger} as a subscriber to the 'errorChannel' channel
2019-01-16 08:32:26.829  INFO 31499 --- [           main] o.s.i.channel.PublishSubscribeChannel    : Channel 'application.errorChannel' has 1 subscriber(s).
2019-01-16 08:32:26.830  INFO 31499 --- [           main] o.s.i.endpoint.EventDrivenConsumer       : started _org.springframework.integration.errorLogger
2019-01-16 08:32:26.872  INFO 31499 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
2019-01-16 08:32:26.875  INFO 31499 --- [           main] c.c.citrus.simulator.sample.Simulator    : Started Simulator in 8.207 seconds (JVM running for 11.418)

```
That basically means the web service has been launched by Tomcat on port 8080.
So if you have a browser, you can visit this link to access the Citrus Simualtor UI now:
```
http://<simulator_IP>:8080
```

Note: if the simulator is installed on a VM in a ```resource group``` with ```Load Balancer```, then you need to configure its ```"Inbound NAT rules"``` to make it pass the ```TCP 8080``` traffic to the real backend VM.

## How does this work?

Let's take a look at the code.

In the Simulator github homepage, the readme said that we need to do some thing for ```"As the simulator is a normal Spring boot application we just add a usual main class."```, and ```"In addition to that we should define one to many simulator scenarios that execute when requests are received."```. And then it tells you some piece of code like this:

**"usual main class"**

```
package com.consol.citrus.simulator;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Simulator {

    public static void main(String[] args) {
        SpringApplication.run(Simulator.class, args);
    }
}
```

**"test scenario"**

```
package com.consol.citrus.simulator;

import com.consol.citrus.http.message.HttpMessage;
import com.consol.citrus.simulator.scenario.*;
import org.springframework.http.HttpStatus;

@Scenario("DEFAULT_SCENARIO")
public class DefaultScenario extends AbstractSimulatorScenario {

    @Override
    public void run(ScenarioDesigner designer) {
        designer.echo("Default scenario executed!");

        designer.send()
                .message(new HttpMessage("Welcome to the Citrus simulator")
                .status(HttpStatus.OK));
    }
}
```

This is very confusing to new people like me. After I have successfully brought up the Sample Simulator online then I came back and looked at its github source code, I understand that above sentences are trying to tell you of **how to start writing new test scenarios to handle your own requests**.

In above example, the source code is here ```"citrus-simulator/simulator-samples/sample-ws/"```. If you go to ```"simulator-samples/sample-ws/src/main/java/com/consol/citrus/simulator/sample/"```, you will see 1 file and 2 folders:
* ```Simulator.java``` (this is the ```"main class"```)
* ```scenario``` (```DefaultScenario.java```; ```GoodByeScenario.java```;  
```GoodNightScenario.java```; ```HelloScenario.java```)
* ```starter``` (```GoodByeStarter.java```; ```HelloStarter.java```)

That's why you see those entries in the web UI, ```scenario``` Tab (in the example, there are 4 scenarios and 2 starters, which map to the code here). If you open the above Java code, you will see they map to the github homepage instructions exactly.

You surely can add more test scenarios, or handle even more complex test scenarios; but you need to write such Java code to implement that.
