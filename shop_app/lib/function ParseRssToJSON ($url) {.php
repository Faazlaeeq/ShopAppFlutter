<?php
    function ParseRssToJSON ($url) {

        $fileContents=file_get_contents($url);
        $fileContents = str_replace(array("\n", "\r", "\t"), '', $fileContents); 
        $fileContents = trim(str_replace('"',"'", $fileContents));
        $simpleXml = simplexml_load_string($fileContents); 
        $json = json_encode($simpleXml); 
        return $json;
    }
        // Fetch a url and echo it back to stdout
        function getUrl($url) { 
            //error_log("Fetch:". Surl);
        
            $handle = fopen($url, "rb"); 
            $ret = stream_get_contents($handle);
            fclose($handle);
            echo $ret;
        }
        // Start the party
        if (isset($_GET['url'])) { 
            getUrl($_GET['url']);
        }
        else { 
            error_log("Err: yo! you are missing the url to fetch for you."); echo "You must send a 'url' so the proxy will work ";
        }
?>
proxy.php?url=http://www.oref.org.il/WarningMessages/Alert/alerts.json?v=1