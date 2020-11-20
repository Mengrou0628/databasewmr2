一、如何导入翻译记忆库tmx文件
1. 使用DOMDocument读XML文件

>```php
><?php
>
>//XML标签配置，根据具体需要
>$xmlTag = array(
>    'starttime',
>    'endtime',
>    'school'
>);
>$dom = new DOMDocument();
>$dom->load('./write_dom.xml');
>$periods = $dom->getElementsByTagName('period');
>$study = array();
>foreach($periods as $k => $p) {
>    foreach($xmlTag as $x) {
>        $node = $p->getElementsByTagName($x);
>        $study[$k][$x] = $node->item(0)->nodeValue;
>    }
>}
>echo '<pre>';
>print_r($study);?>
>```
>
>

2. 用字符串方式读XML*(处理大型xml文件更为迅速)



```php
<?php

$file = './write_str.xml';
$con = file_get_contents($file);

//XML标签配置，根据具体需要
$xmlTag = array(
    'starttime',
    'endtime',
    'school'
);

$arr = array();
foreach($xmlTag as $x) {
    preg_match_all("/<".$x.">.*<\/".$x.">/", $con, $temp);
    $arr[] = $temp[0];
}
//去除XML标签并组装数据
$data = array();
foreach($arr as $key => $value) {
    foreach($value as $k => $v) {
        $a = explode($xmlTag[$key].'>', $v);
        $v = substr($a[1], 0, strlen($a[1])-2);
        $data[$k][$xmlTag[$key] = $v;
    }
}
echo '<pre>';
print_r($data);?>
```



3. 使用simplexml读xml文件

```php
<?php

//XML标签配置，根据具体需要
$xmlTag = array(
    'starttime',
    'endtime',
    'school'
);
$study = array();
$xml = simplexml_load_file('./write_sim.xml');
foreach($xml->children() as $period) {
 foreach($xmlTag as $x){
    $study[] = get_object_vars($period[$x]);//获取对象全部属性，返回数组**(不确定)
}
}
echo '<pre>';
print_r($study);?>
```



4. 用phpquery精确获取xml文件内容**（不太清楚如何应用）
  

  ```php
  <?php
  include 'phpQuery/phpQuery.php'; 
  phpQuery::newDocumentFile('test.xml'); 
  echo pq('contact > age:eq(序号)');//还有其他获取节点的方法
  ?>
  ```

  

5. 用php将得到数组里的数据插入Mysql数据库
  

```php
 $sql = "INSERT INTO 表名称 (column 1, column 2, column 3)
   VALUES (value 1, value 2, value 3)";

if ($conn->query($sql) === TRUE) {
    echo "新记录插入成功";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
```




二、如何导出翻译记忆库文件tmx
1. 使用字符串方法写xml

```php
<?php

//config.php
 $servername = "localhost";
   $username = "root";
   $password = "";
   $dbname = "cattool";
    
   // 创建连接
   $conn = new mysqli($servername, $username, $password, $dbname);
   // 检测连接
   if ($conn->connect_error) {
       die("连接失败: " . $conn->connect_error);
   }

$sql = 'select * from 表名称';
$res = mysqli_query($mysqli, $sql);
$study = array();
while($row = mysqli_fetch_array($res)) {
    $study[] = $row;
}
//XML标签配置，根据具体需要
$xmlTag = array(
    'starttime',
    'endtime',
    'school'
);

$str = "<studentcareer>\n";
foreach($study as $v) {
    $str .= "\t<period>\n";
    foreach($xmlTag as $x) {
        $str .= "\t\t<".$x.">" . $v[$x] . "</".$x.">\n";
    }
    $str .= "\t</period>\n";
}
$str .= '</studentcareer>';

$file = './write_str.xml'; //注意生成xml文件的路径
file_put_contents($file, $str);
```



2. 使用simplexml方法写xml

   ```php
   <?php
   
   //config.php
    $servername = "localhost";
      $username = "root";
      $password = "";
      $dbname = "cattool";
       
      // 创建连接
      $conn = new mysqli($servername, $username, $password, $dbname);
      // 检测连接
      if ($conn->connect_error) {
          die("连接失败: " . $conn->connect_error);
      }
   
   $sql = 'select * from 表名称';
   $res = mysqli_query($mysqli, $sql);
   $study = array();
   while($row = mysqli_fetch_array($res)) {
       $study[] = $row;
   }
   
   //XML标签配置，根据具体需要
   $xmlTag = array(
       'starttime',
       'endtime',
       'school'
   );
   $xml = new SimpleXMLElement('<?xml version="1.0" encoding="UTF-8"?><studentcareer />');
   foreach($study as $s) {
       $period = $xml->addChild('period');
       foreach($xmlTag as $x) {
           $period->addChild($x, $s[$x]);
       }
   }
   $xml->asXml('./write_sim.xml');//输出XML文件，注意输出文件的路径
   ```

   

三、如何导出xliff(xml-based created to standardize localization)双语文件
*同二如何导出xml文件*


四、如何导入txt,doc,xlsx文件
1. PHPWord

```php
<?php
use PhpOffice\PhpWord\PhpWord;
use PhpOffice\PhpWord\IOFactory;

$info = public_path().'/uploads/admin/examination/test.docx';
$phpWord = new PhpWord();
$sections =IOFactory::load($info)->getSections();

foreach($sections as $section) {

　　$elements = $section->getElements();
　　foreach($elements as $element) {

　　　　echo $element->getElements()[0]->getText() . "\n";
　　}
}
?>
```



2. PHPExcel

  

>```php
> <?php
>   $PHPExcel=new PHPExcel();
>   $PHPReader=new PHPExcel_Reader_Excel2007();
>   if(!$PHPReader->canRead($filePath)){
>   $PHPReader=new PHPExcel_Reader_Excel5();
>   if(!$PHPReader->canRead($filePath)){
>   echo 'no Excel';
>   return;
>   }
>   }
>   $PHPExcel=$PHPReader->load($filePath);
>   $sheetCount=$PHPExcel->getSheetCount();
>   $currentSheet=$PHPExcel->getSheet(0);
>   $allColumn = $currentSheet->getHighestColumn(); 
>
>/**取得一共有多少行*/ 
>
>$allRow = $currentSheet->getHighestRow(); 
>$excelResult = array(); 
>//声明数组
>
>//从第一行开始读取数据
>    $startRow = $redis->get('startRow') ? $redis->get('startRow')+1 : 2;
>    $endRow = $startRow + 500;
>    if($endRow >= $allRow){
>        $endRow = $allRow;
>    }
>    for ($j = $startRow; $j <= $endRow; $j++) {
>        //从A列读取数据
>        for ($k = 'A'; $k <= $allColumn; $k++) {
>            // 读取单元格
>            $excelResult[$j][] = (string)$phpExcel->getActiveSheet()->getCell("$k$j")->getValue();
>        }
>    }
>    dp($excelResult);
>}
>```
>
>
3. txt直接读取
>```php
><?php
>$f_chr=file_get_contents("002.txt");
>echo $f_chr;
>>
>```
>
>
4. 文档处理模块服务化

五、如何导出术语库xlsx文件
1. phpexcel类

```php
<?php
/**

 * PHPExcel应用之一 写xlxs文件 并提供下载
   **/

require_once dirname(__FILE__) . '/PHPExcel/Classes/PHPExcel.php';
$objExcel = new PHPExcel();

//xlsx相关属性操作方法  关联类 PHPExcel/Classes/PHPExcel/DocumnentProperties.php
$objExcel->getProperties()->setCreator("author")                  //设置作者
                            ->setLastModifiedBy("last save author")  //最后一次保存者
                            ->setTitle("title")                      //标题
                            ->setSubject("subject")                  //主题
                            ->setDescription("remark")               //备注
                            ->setKeywords("mark")                    //标记
                            ->setCategory("category");               //类别
                             
                             
//对sheet cell进行操作
$objExcel->setActiveSheetIndex(0)                //会返回worksheet对象 关联类 PHPExcel/Classes/PHPExcel/Worksheet.php
            ->setCellValue('A1', 'A1')
            ->setCellValue('B1', 'B1')
            ->setCellValue('C1', 'C1')
            ->setCellValue('D1', 'D1');
             
$objExcel->setActiveSheetIndex(0)                //会返回worksheet对象 关联类 PHPExcel/Classes/PHPExcel/Worksheet.php
            ->setCellValue('A2', 'A2')
            ->setCellValue('B2', 'B2')
            ->setCellValue('C2', 'C2')
            ->setCellValue('D2', 'D2');
             
             
//设置sheet标题
$objExcel->getActiveSheet()->setTitle('the first sheet');

//设置为第一个sheet为活动状态
$objExcel->setActiveSheetIndex(0);

//保存
$filename = "test.xlsx";
$objWriter = PHPExcel_IOFactory::createWriter($objExcel, 'Excel2007');
$objWriter->save($filename);

//如果生成并提供下载
header('Content-Type: application/vnd.ms-excel');
header('Content-Disposition: attachment;filename="'.$filename);
header('Cache-Control: max-age=0');
header('Cache-Control: max-age=1');
header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
header('Last-Modified: '.gmdate('D, d M Y H:i:s').' GMT');
header('Cache-Control: cache, must-revalidate');
header('Pragma: public');
     
$objWriter = PHPExcel_IOFactory::createWriter($objExcel, 'Excel2007');
$objWriter->save('php://output');
```



```php
<?php
/**

 * PHPExcel应用之一 写xlxs文件 并提供下载
   **/

require_once dirname(__FILE__) . '/PHPExcel/Classes/PHPExcel.php';
$objExcel = new PHPExcel();

//xlsx相关属性操作方法  关联类 PHPExcel/Classes/PHPExcel/DocumnentProperties.php
$objExcel->getProperties()->setCreator("author")                  //设置作者
                            ->setLastModifiedBy("last save author")  //最后一次保存者
                            ->setTitle("title")                      //标题
                            ->setSubject("subject")                  //主题
                            ->setDescription("remark")               //备注
                            ->setKeywords("mark")                    //标记
                            ->setCategory("category");               //类别
                             
                             
//对sheet cell进行操作
$objExcel->setActiveSheetIndex(0)                //会返回worksheet对象 关联类 PHPExcel/Classes/PHPExcel/Worksheet.php
            ->setCellValue('A1', 'A1')
            ->setCellValue('B1', 'B1')
            ->setCellValue('C1', 'C1')
            ->setCellValue('D1', 'D1');
             
$objExcel->setActiveSheetIndex(0)                //会返回worksheet对象 关联类 PHPExcel/Classes/PHPExcel/Worksheet.php
            ->setCellValue('A2', 'A2')
            ->setCellValue('B2', 'B2')
            ->setCellValue('C2', 'C2')
            ->setCellValue('D2', 'D2');
             
             
//设置sheet标题
$objExcel->getActiveSheet()->setTitle('the first sheet');

//设置为第一个sheet为活动状态
$objExcel->setActiveSheetIndex(0);

//保存
$filename = "test.xlsx";
$objWriter = PHPExcel_IOFactory::createWriter($objExcel, 'Excel2007');
$objWriter->save($filename);

//如果生成并提供下载
header('Content-Type: application/vnd.ms-excel');
header('Content-Disposition: attachment;filename="'.$filename);
header('Cache-Control: max-age=0');
header('Cache-Control: max-age=1');
header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
header('Last-Modified: '.gmdate('D, d M Y H:i:s').' GMT');
header('Cache-Control: cache, must-revalidate');
header('Pragma: public');
     
$objWriter = PHPExcel_IOFactory::createWriter($objExcel, 'Excel2007');
$objWriter->save('php://output');
```




2. 原生Php

```php
$mysqli = mysqli_connect('localhost', 'root', '', 'cattool');
$sql = 'select * from terminology';
$res = mysqli_query($mysqli, $sql);
$file = fopen('./country.xls', 'w');
fwrite($file, "code\tname\tpopulation\t\n");
if(mysqli_num_rows($res) > 0) {
 while($row = mysqli_fetch_array($res)) {
     fwrite($file, $row['code']."\t".$row['name']."\t".$row['population']."\t\n");//这里写得不好，应该把所有文件内容组装到一个字符串中然后一次性写入文件。
 }
}
fclose($file);
echo '....../terminology.xls';//这里返回文件路径给js
```