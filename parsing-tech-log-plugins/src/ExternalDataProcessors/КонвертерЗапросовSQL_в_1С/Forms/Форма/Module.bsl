&НаКлиенте
Перем Модуль_СервисныеФункции;

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	Версия = РеквизитФормыВЗначение("Объект").СведенияОВнешнейОбработке().Версия;
	ЭтаФорма.Заголовок = "версия "+Версия;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Если НЕ ЗначениеЗаполнено(ДлинаКоличестваПолейПредсталенияИндекса) Тогда
		ДлинаКоличестваПолейПредсталенияИндекса=2;
	КонецЕсли;
	Если НЕ ЗначениеЗаполнено(ТекущийОтборПолей) Тогда
		ТекущийОтборПолей="ТаблицаМетаданных";
	КонецЕсли;
	Элементы.ГдеИскать.СписокВыбора.Добавить("ИмяТаблицыХранения","имя хранения");
	Элементы.ГдеИскать.СписокВыбора.Добавить("ИмяТаблицы","имя таблицы");
	Если НЕ ЗначениеЗаполнено(ГдеИскать) Тогда
		ГдеИскать="ИмяТаблицыХранения";
	КонецЕсли;
	Элементы.ТекущийОтборПолей.СписокВыбора.Добавить("ТаблицаМетаданных","Метаданные");
	Элементы.ТекущийОтборПолей.СписокВыбора.Добавить("ТаблицаИндексовМетаданных","Индексы");
	Модуль_СервисныеФункции = ПолучитьФорму("ВнешняяОбработка.КонвертерЗапросовSQL_в_1С.Форма.Модуль_СервисныеФункции",Неопределено,ЭтаФорма);
	ПоискПоМетаданным();
	ЗаполнятьТаблицуМетаданныхПриИзменении(Неопределено);
	
	Если НЕ ЗначениеЗаполнено(ТипТаблицы) Тогда
		ТипТаблицы = "все";
	КонецЕсли;                                                  
	
	Элементы.ТипТаблицы.СписокВыбора.Добавить("все","все");
	Элементы.ТипТаблицы.СписокВыбора.Добавить("Перечисление","перечисление");
	Элементы.ТипТаблицы.СписокВыбора.Добавить("Справочник","справочники");
	Элементы.ТипТаблицы.СписокВыбора.Добавить("Документ","документы");
	Элементы.ТипТаблицы.СписокВыбора.Добавить("РегистрСведений","регистр сведен.");
	Элементы.ТипТаблицы.СписокВыбора.Добавить("РегистрНакопления","регистр накопл.");
	Элементы.ТипТаблицы.СписокВыбора.Добавить("РегистрРасчета","регистр расчета");
	Элементы.ТипТаблицы.СписокВыбора.Добавить("РегистрБухгалтерии","регистр бух.");
	Элементы.ТипТаблицы.СписокВыбора.Добавить("Задачи","задачи");
	Элементы.ТипТаблицы.СписокВыбора.Добавить("ПланыВидовХарактеристик","ПВХ");
	
КонецПроцедуры

&НаСервере
Процедура ПреобразоватьНаСервере(ОбновлятьТаблицы=Ложь)
	
	//1 сначала парсим скл запрос на слова
	Текст = нрег(ТекстЗапросаSQL);
	СлужебныеСловаСимволы = ", ; ( ) N' ' = > < .   ";
	
	// иначе план MSSQL ломается
	Если НЕ ЭтоПланЗапроса Тогда
		СлужебныеСловаСимволы = СлужебныеСловаСимволы+" @ ";
	КонецЕсли;
	
	СлужебныеСловаСимволы = СлужебныеСловаСимволы + " SELECT TOP CASE WHEN THEN ELSE TRUE FALSE INTO HAVING
	| LEFT OUTER JOIN FROM WHERE GROUP ORDER CASE MAX MIN CAST NUMERIC  NULL EXISTS NOT NULL DESC END  SELECT  SDBL_DUMMY SDBL_DUAL INNER JOIN 
	| 0x00000000000000000000000000000000 
	| AND AS IS OR BY ON IN 
	| T1 T2 T3 T4 T5 T6 T7 T8 T9 T10 T11 T12 dbo bytea mvarchar
	|";
	МассивСлужебных = xСтрРазделить(СлужебныеСловаСимволы," ",Ложь);
	КешСлужебныхСимволов = Новый Соответствие;
	
	Для каждого стр из МассивСлужебных Цикл
		КешСлужебныхСимволов.Вставить(Нрег(СокрЛП(стр)),Истина);
	КонецЦикла;
	
	Текст = СтрЗаменить(Текст,","," ");
	Текст = СтрЗаменить(Текст,"("," ( ");
	Текст = СтрЗаменить(Текст,")"," ) ");
	Текст = СтрЗаменить(Текст,"["," [ ");
	Текст = СтрЗаменить(Текст,"]"," ] ");
	Текст = СтрЗаменить(Текст,"<"," < ");
	Текст = СтрЗаменить(Текст,">"," > ");
	Текст = СтрЗаменить(Текст,""""," "" ");
	Текст = СтрЗаменить(Текст,":"," : ");
	Текст = СтрЗаменить(Текст,"="," = ");
	Текст = СтрЗаменить(Текст,"Expense"," Expense ");
	Текст = СтрЗаменить(Текст,"Receipt"," Receipt ");
	Текст = СтрЗаменить(Текст,"Turnover"," Turnover ");
	Текст = СтрЗаменить(Текст,"InitialBalance"," InitialBalance ");
	Текст = СтрЗаменить(Текст,"FinalBalance"," FinalBalance ");
	Текст = СтрЗаменить(Текст,"Balance"," Balance ");
	//Текст = СтрЗаменить(Текст,"rrref"," rrref ");
	//Текст = СтрЗаменить(Текст,"rref"," rref ");
	Текст = СтрЗаменить(Текст," ",Символы.ПС);
	
	
	Массив = xСтрРазделить(Текст,Символы.ПС,Ложь);
	
	ТаблицаСлов.Очистить();
	Для каждого стр из Массив Цикл
		стр = СокрЛП(стр);
		Слово = НРег(стр);
		Если НЕ ЗначениеЗаполнено(Слово) Тогда
			Продолжить;
		КонецЕсли;
		Если КешСлужебныхСимволов.Получить(Слово)=Истина Тогда
			Продолжить;
		КонецЕсли;
		Если СтрДлина(Слово)<5 Тогда
			продолжить;
		КонецЕсли;;
		Если Найти(Слово,"0x") Тогда
			Продолжить;
		КонецЕсли;
		Если Найти(стр,".") Тогда
			МассивСлов = xСтрРазделить(стр,".",Ложь);
			Если МассивСлов.Количество()=2 Тогда
				стр_н = ТаблицаСлов.Добавить();
				стр_н.слово = МассивСлов[0]+".";
				стр_н.длина = СтрДлина(МассивСлов[0]+1);
				стр_н.код_слово = ПолучитьКодСлова(НРег(стр_н.слово));
				стр_н = ТаблицаСлов.Добавить();
				стр_н.слово = МассивСлов[1];
				стр_н.длина = СтрДлина(МассивСлов[1]);
				стр_н.код_слово = ПолучитьКодСлова(НРег(стр_н.слово));
			Иначе
				стр_н = ТаблицаСлов.Добавить();
				стр_н.слово = стр;
				стр_н.длина = СтрДлина(стр);
				стр_н.код_слово = ПолучитьКодСлова(Слово);
			КонецЕсли;
		Иначе
			стр_н = ТаблицаСлов.Добавить();
			стр_н.слово = стр;
			стр_н.длина = СтрДлина(стр);
			стр_н.код_слово = ПолучитьКодСлова(Слово);
		КонецЕсли;
	КонецЦикла;
	
	Запрос = новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	Т.слово КАК слово,
	|	Т.код_слово КАК код_слово,
	|	Т.длина КАК Длина
	|ПОМЕСТИТЬ ТЗ
	|ИЗ
	|	&ТЗ КАК Т
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВЫРАЗИТЬ(ТЗ.слово КАК СТРОКА(155)) КАК слово,
	|	ВЫРАЗИТЬ(ТЗ.код_слово КАК СТРОКА(155)) КАК код_слово,
	|	ТЗ.Длина КАК Длина
	|ИЗ
	|	ТЗ КАК ТЗ
	|
	|УПОРЯДОЧИТЬ ПО
	|	Длина УБЫВ";
	
	
	Запрос.УстановитьПараметр("ТЗ",ТаблицаСлов.Выгрузить());
	ТаблицаСлов.Загрузить(Запрос.Выполнить().Выгрузить());
	
	ТекстЗапроса1С = "";
	Для каждого стр из ТаблицаСлов Цикл
		ТекстЗапроса1С = ТекстЗапроса1С+ СокрЛП(стр.слово)+Символы.ПС;
	КонецЦикла;
	
	СтруктураХранения = Неопределено;
	СоответсвиеТаблиц = новый Соответствие;
	СоответсвиеРеквизитов = новый Соответствие;
	
	Если ЭтоАдресВременногоХранилища(АдресХранилища) Тогда
		СтруктураХранения = ПолучитьИзВременногоХранилища(АдресХранилища);
		Если НЕ СтруктураХранения=Неопределено Тогда
			//РезультатТаблиц = СтруктураХранения.РезультатТаблиц;
			СоответсвиеТаблиц = СтруктураХранения.СоответсвиеТаблиц;
			СоответсвиеРеквизитов = СтруктураХранения.СоответсвиеРеквизитов;
		КонецЕсли;
	КонецЕсли;
	
	Если СтруктураХранения=Неопределено ИЛИ ОбновлятьТаблицы=Истина Тогда
		РезультатТаблиц = ПолучитьСтруктуруХраненияБазыДанных(,Истина);
		
		//ТаблицаМетаданных.Загрузить(РезультатТаблиц);
		ТаблицаМетаданных.Очистить();
		ТаблицаПолейМетеданных.Очистить();
		ТаблицаИндексовМетаданных.Очистить();
		
		Для каждого стр из РезультатТаблиц Цикл
			
			Если ЗаполнятьТаблицуМетаданных=Истина Тогда
				стр_метадан_н = ТаблицаМетаданных.Добавить();
				ЗаполнитьЗначенияСвойств(стр_метадан_н,стр);
				УказатьТипТаблицы(стр_метадан_н);
			КонецЕсли;
			
			СтруктураТаблицы = Новый Структура("Метаданные,ИмяТаблицыХранения,Назначение");
			ЗаполнитьЗначенияСвойств(СтруктураТаблицы,стр);
			СоответсвиеТаблиц.Вставить(НРег(стр.ИмяТаблицыХранения),СтруктураТаблицы);
			код_слова = ПолучитьКодСлова(стр.ИмяТаблицыХранения);
			СоответсвиеТаблиц.Вставить(НРег(код_слова),СтруктураТаблицы);
			МассивРеквизитов = Новый Массив;
			Для каждого рек из стр.Поля Цикл
				
				// TODO: переделать эту хрень
				СтурктураРекизита = Новый Структура("ИмяПоляХранения,ИмяПоля,Метаданные");
				ЗаполнитьЗначенияСвойств(СтурктураРекизита,рек);
				
				ДобавитьСоответсвиеРеквизитовЕслиТребуется(НРег(рек.ИмяПоляХранения), СоответсвиеРеквизитов, СтурктураРекизита);
				ДобавитьСоответсвиеРеквизитовЕслиТребуется(ПолучитьКодСлова(НРег(рек.ИмяПоляХранения)), СоответсвиеРеквизитов, СтурктураРекизита);
				
				СтруктураРеквизита = новый Структура("ИмяПоляХранения,ИмяПоля");
				ЗаполнитьЗначенияСвойств(СтруктураРеквизита,рек);
				МассивРеквизитов.Добавить(СтруктураРеквизита);
				
			КонецЦикла;
			Если ЗаполнятьТаблицуМетаданных=Истина Тогда
				стр_метадан_н.ХранилищеРеквизитов = Новый ХранилищеЗначения(МассивРеквизитов);
			КонецЕсли;
			// индексы
			ш=0;
			Для каждого инд из стр.Индексы Цикл
				ш=ш+1;
				код_слова = НРег(инд.ИмяИндексаХранения);
				СтруктураТаблицыИндекса = Новый Структура("Метаданные,ИмяТаблицыХранения");
				ЗаполнитьЗначенияСвойств(СтруктураТаблицы,стр);
				СтруктураТаблицыИндекса.ИмяТаблицыХранения = инд.ИмяИндексаХранения;
				Если ЗаполнятьТаблицуМетаданных=Истина Тогда
					стр_ни = ТаблицаИндексовМетаданных.Добавить();
					ЗаполнитьЗначенияСвойств(стр_ни,инд);
					стр_ни.Ключ = стр.ИмяТаблицыХранения+"->"+стр.ИмяТаблицы;
				КонецЕсли;
				ИмяТаблицыХранения = "";
				КешПолей = Новый Соответствие;
				МассивРеквизитов = Новый Массив;
				Для каждого пол_и из инд.Поля Цикл
					код_измерения = пол_и.ИмяПоляХранения;
					
					СтруктураРеквизита = новый Структура("ИмяПоляХранения,ИмяПоля");
					ЗаполнитьЗначенияСвойств(СтруктураРеквизита,пол_и);
					МассивРеквизитов.Добавить(СтруктураРеквизита);
					
					
					СтруктураРеквизита = СоответсвиеРеквизитов.Получить(НРег(код_измерения));
					Если НЕ СтруктураРеквизита=Неопределено Тогда
						Если ЗначениеЗаполнено(СтруктураРеквизита.ИмяПоля) Тогда
							КешПолей.Вставить(СтруктураРеквизита.ИмяПоля,СтруктураРеквизита.ИмяПоля);
						КонецЕсли;
					КонецЕсли;
				КонецЦикла;
				Если ЗаполнятьТаблицуМетаданных=Истина Тогда
					стр_ни.ХранилищеРеквизитов = Новый ХранилищеЗначения(МассивРеквизитов);
				КонецЕсли;
				м=0;
				Для каждого пол_и из КешПолей Цикл
					м=м+1;
					ИмяТаблицыХранения = ИмяТаблицыХранения+?(ЗначениеЗаполнено(ИмяТаблицыХранения),","+пол_и.Ключ,пол_и.Ключ);
					Если м>ДлинаКоличестваПолейПредсталенияИндекса Тогда
						Прервать;
					КонецЕсли;
				КонецЦикла;
				
				суф = СтрЗаменить(НРег(инд.ИмяИндексаХранения),НРег(стр.ИмяТаблицыХранения),"");   
				Если ЗначениеЗаполнено(суф) И СтрДлина(суф)<10 Тогда
					СтруктураТаблицыИндекса.ИмяТаблицыХранения = стр.ИмяТаблицы+".Индекс"+суф;
				Иначе
					СтруктураТаблицыИндекса.ИмяТаблицыХранения = стр.ИмяТаблицы+".Индекс_"+ш;
				КонецЕсли;         
				Если НеДобавлятьСоставИндексов=Ложь Тогда
					СтруктураТаблицыИндекса.ИмяТаблицыХранения = СтруктураТаблицыИндекса.ИмяТаблицыХранения+"["+ИмяТаблицыХранения+"]";
				КонецЕсли;

				СоответсвиеТаблиц.Вставить(ПолучитьКодСлова(код_слова),СтруктураТаблицыИндекса);
			КонецЦикла;
			
		КонецЦикла;	
		
		//СтруктураХранения = Новый Структура("РезультатТаблиц,СоответсвиеТаблиц,СоответсвиеРеквизитов",РезультатТаблиц,СоответсвиеТаблиц,СоответсвиеРеквизитов);
		СтруктураХранения = Новый Структура("СоответсвиеТаблиц,СоответсвиеРеквизитов",СоответсвиеТаблиц,СоответсвиеРеквизитов);
		АдресХранилища = ПоместитьВоВременноеХранилище(СтруктураХранения,ЭтаФорма.УникальныйИдентификатор);

	КонецЕсли;   	

	
	Для каждого стр из ТаблицаСлов Цикл
		Ключ = стр.Слово;
		Результат = СоответсвиеТаблиц.Получить(Ключ);
		Если Результат<>Неопределено Тогда
			стр.Метаданные = ?(ЗначениеЗаполнено(Результат.Метаданные),Результат.Метаданные,Результат.ИмяТаблицыХранения);
			стр.ЭтоТаблица = Истина;
			продолжить;
		КонецЕсли;
		Код_слова = ПолучитьКодСлова(стр.Слово);
		Результат = СоответсвиеТаблиц.Получить(НРег(Код_слова));
		Если Результат<>Неопределено Тогда
			стр.Метаданные = ?(ЗначениеЗаполнено(Результат.Метаданные),Результат.Метаданные,Результат.ИмяТаблицыХранения);
			стр.ЭтоТаблица = Истина;
			продолжить;
		КонецЕсли;
		
		Ключ = стр.Слово;
		Результат = СоответсвиеРеквизитов.Получить(Ключ);
		Если Результат<>Неопределено Тогда
			стр.Метаданные = ?(ЗначениеЗаполнено(Результат.ИмяПоля),Результат.ИмяПоля,Результат.ИмяПоляХранения);;
		КонецЕсли;
		Код_слова = ПолучитьКодСлова(стр.Слово);
		Результат = СоответсвиеРеквизитов.Получить(НРег(Код_слова));
		Если Результат<>Неопределено Тогда
			стр.Метаданные = ?(ЗначениеЗаполнено(Результат.ИмяПоля),Результат.ИмяПоля,Результат.ИмяПоляХранения);;
		КонецЕсли;
		
	КонецЦикла;

	ДвойнаяКавычка = """";
	Если НеДобавлятьДвойныеКавычкиДляТаблиц=Истина ИЛИ ЭтоПланЗапроса=Ложь Тогда
		ДвойнаяКавычка="";
	КонецЕсли;
	
	// подставляем
	Текст = Нрег(ТекстЗапросаSQL);
	ТекстДляЗамены = ТекстЗапросаSQL;
	Для каждого стр из ТаблицаСлов Цикл
		Если НЕ ЗначениеЗаполнено(стр.Метаданные) Тогда
			Продолжить;
		КонецЕсли;
		Позиция=СтрНайти(Текст,стр.слово);                    
		Если стр.ЭтоТаблица=Истина И НЕ ЭтоПланЗапроса=Истина Тогда
			Замена = ДвойнаяКавычка+стр.Метаданные+ДвойнаяКавычка+" AS ";
		Иначе
			Замена = ДвойнаяКавычка+стр.Метаданные+ДвойнаяКавычка;
		КонецЕсли; 		                      		
		
		Пока Позиция<>0 Цикл                  
			
			Текст = Лев(Текст,Позиция-1)+Замена+Сред(Текст,Позиция+СтрДлина(стр.слово));			
			ТекстДляЗамены = Лев(ТекстДляЗамены,Позиция-1)+Замена+Сред(ТекстДляЗамены,Позиция+СтрДлина(стр.слово));			
			Позиция=СтрНайти(Текст,стр.слово);	
		
		КонецЦикла;
	КонецЦикла;
	
	Если НЕ ЭтоПланЗапроса=Истина Тогда
		ТекстДляЗамены = СтрЗаменить(ТекстДляЗамены,") T",") AS T");
	КонецЕсли;
	
	Если ЭтоПланЗапроса=Истина Тогда
		ТекстДляЗамены = СтрЗаменить(ТекстДляЗамены,"public.","");
	КонецЕсли;       
	
	
	КлючевыеСловаEngRus = "/SELECT/ВЫБРАТЬ/
	|/DISTINCT/РАЗЛИЧНЫЕ/      
	|/LIMIT/ПЕРВЫЕ/
	|/ALLOWED/РАЗРЕШЕННЫЕ/
	|/FROM/ИЗ/
	|/AS/КАК/
	|/UNION_ALL/ОБЪЕДИНИТЬ_ВСЕ/
	|/UNION/ОБЪЕДИНИТЬ/
	|/GROUP_BY/СГРУППИРОВАТЬ_ПО/
	|/GROUP/СГРУППИРОВАТЬ/
	|/CASE/ВЫБОР/
	|/WHEN/КОГДА/
	|/HAVING/ИМЕЮЩИЕ/
	|/INSERT_INTO/ПОМЕСТИТЬ/
	|/INTO/В/
	|/INSERT/ПОМЕСТИТЬ/
	|/THEN/ТОГДА/
	|/ELSE/ИНАЧЕ/
	|/END/КОНЕЦ/
	|/LEFT OUTER JOIN/ЛЕВОЕ СОЕДИНЕНИЕ/
	|/INNER JOIN/ВНУТРЕННЕЕ СОЕДИНЕНИЕ/
	|/_IN_/_В_/
	|/_AND_/_И_/
	|/_OR_/_ИЛИ_/
	|/_ON_/_ПО_/
	|/WHERE/ГДЕ/
	|/HAVING_BY/СГРУППИРОВАТЬ_ПО/
	|/ORDER_BY/СОРТИРОВАТЬ_ПО/
	|/DESC/УБЫВ/
	|/SUM/СУММА/
	|/AVG/СРЕДНЕЕ/
	|/MAX/МАКСИМУМ/
	|/MIN/МИНИМУМ/
	|/ISNULL/ЕСТЬNULL/
	|/IS NULL/ЕСТЬNULL/
	|/dbo./_/
	|/CAST/ВЫРАЗИТЬ/
	|/NUMERIC/ЧИСЛО/
	|/TRUE/ИСТИНА/
	|/FALSE/ЛОЖЬ/
	|/RecordKind/ВидЗаписи/
	|/Expense/Расход/
	|/Receipt/Приход/
	|/Turnover/Оборот/
	|/InitialBalance/НачальныйОстаток/
	|/FinalBalance/КонечныйОстаток/
	|/Balance/Остаток/
	|";                                     

	Если НЕ ЭтоПланЗапроса Тогда
		КлючевыеСловаEngRus = КлючевыеСловаEngRus+Символы.ПС+"@/&";		
	КонецЕсли;
	
	Если ПреобразоватьНаРусский=Истина Тогда      
		КлючевыеСловаEngRus = СтрЗаменить(КлючевыеСловаEngRus,Символы.ПС,"");
		КлючевыеСловаEngRus = СтрЗаменить(КлючевыеСловаEngRus," ","");
		КлючевыеСловаEngRus = СтрЗаменить(КлючевыеСловаEngRus,"_"," ");
		МассивСловПеревод = xСтрРазделить(КлючевыеСловаEngRus,"/",Ложь);
		Для ш=0 по МассивСловПеревод.ВГраница()-1 Цикл
			СловоEng = МассивСловПеревод[ш];
			СловоRus = МассивСловПеревод[ш+1];
			ТекстДляЗамены = СтрЗаменить(ТекстДляЗамены,СловоEng,СловоRus);	
			ш=ш+1;
		КонецЦикла;   
	КонецЕсли;	
	
	
	ТекстЗапроса1С = ТекстДляЗамены;
	
КонецПроцедуры       

&НаСервере
Процедура УказатьТипТаблицы(ИсточникСтрока)
	Если ЗначениеЗаполнено(ИсточникСтрока.Метаданные) Тогда
		МассивЧастей = СтрРазделить(ИсточникСтрока.Метаданные,".",Ложь);
		Если МассивЧастей.Количество()>0 Тогда
			ИсточникСтрока.ТипТаблицы = МассивЧастей[0];
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ДобавитьСоответсвиеРеквизитовЕслиТребуется(Знач Ключ, СоответсвиеРеквизитов, Знач СтурктураРекизита)
	
	СтурктураРекизита1 = СоответсвиеРеквизитов.Получить(Ключ);
	Если СтурктураРекизита1=Неопределено Тогда
		СоответсвиеРеквизитов.Вставить(Ключ,СтурктураРекизита);
	Иначе
		Если ЗначениеЗаполнено(СтурктураРекизита.ИмяПоля) И НЕ ЗначениеЗаполнено(СтурктураРекизита1.ИмяПоля) Тогда 
			СоответсвиеРеквизитов.Вставить(Ключ,СтурктураРекизита);
		КонецЕсли;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура Преобразовать(Команда)
	ПреобразоватьНаСервере();
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция ПолучитьКодСлова(Знач Слово)
	Код_слово = СокрЛП(Слово);
	Код_слово = СтрЗаменить(Код_слово,"_","");
	Код_слово = СтрЗаменить(Код_слово,"(","");
	Код_слово = СтрЗаменить(Код_слово,")","");
	Код_слово = СтрЗаменить(Код_слово,".","");
	Код_слово = СтрЗаменить(Код_слово,",","");
	Возврат Код_слово;
КонецФункции

#Область СтрРазделить

&НаКлиентеНаСервереБезКонтекста
Функция xСтрРазделить(Знач Строка, Знач Разделитель, Знач ВключатьПустые=Истина) Экспорт
	
	Массив = новый Массив;

	ПоддержкаСтрРазделить = ПроверитьВерсиюПлатформыКонфигурации();
	
	Если ПоддержкаСтрРазделить=Истина Тогда
		Выполнить("Массив = СтрРазделить(Строка,Разделитель,ВключатьПустые);");
	Иначе
		Массив = old_СтрРазделить(Строка,Разделитель,ВключатьПустые);
	КонецЕсли;
	
	Возврат Массив;
КонецФункции

&НаКлиентеНаСервереБезКонтекста
Функция old_СтрРазделить(Знач Строка,Знач Разделитель,Знач ВключатьПустые = Истина) Экспорт
	Результат = Новый Массив;
	
	Если Строка = "" Тогда 
		Если ВключатьПустые Тогда
			Результат.Добавить(Строка);
		КонецЕсли;
		Возврат Результат;
	КонецЕсли;
	
	Позиция = Найти(Строка, Разделитель);
	Пока Позиция > 0 Цикл
		Подстрока = Лев(Строка, Позиция - 1);
		Если ВключатьПустые ИЛИ НЕ Подстрока = "" Тогда
			Результат.Добавить(Подстрока);
		КонецЕсли;
		Строка = Сред(Строка, Позиция + СтрДлина(Разделитель));
		Позиция = Найти(Строка, Разделитель);
	КонецЦикла;
	
	Если ВключатьПустые ИЛИ НЕ Строка = "" Тогда
		Результат.Добавить(Строка);
	КонецЕсли;
		
	Возврат Результат;
КонецФункции

&НаСервереБезКонтекста
Функция ПроверитьВерсиюПлатформыКонфигурации()
	
	ПоддержкаСтрРазделить=Ложь;
	
		СистемнаяИнформация = новый СистемнаяИнформация;
		Если Найти(СистемнаяИнформация.ВерсияПриложения,"8.2.")
			ИЛИ Найти(СистемнаяИнформация.ВерсияПриложения,"8.3.2.") 
			ИЛИ Найти(СистемнаяИнформация.ВерсияПриложения,"8.3.3.")
			ИЛИ Найти(СистемнаяИнформация.ВерсияПриложения,"8.3.4.")
			ИЛИ Найти(СистемнаяИнформация.ВерсияПриложения,"8.3.5.")	 Тогда
			ПоддержкаСтрРазделить=Ложь;
		Иначе 
			// теперь совместимость
			РежимСовместимостиСтрокой = Строка(Метаданные.РежимСовместимости);
			Если Найти(РежимСовместимостиСтрокой,"8_2_")
				ИЛИ Найти(РежимСовместимостиСтрокой,"8_3_2") 
				ИЛИ Найти(РежимСовместимостиСтрокой,"8_3_3")
				ИЛИ Найти(РежимСовместимостиСтрокой,"8_3_4")
				ИЛИ Найти(РежимСовместимостиСтрокой,"8_3_5")	 Тогда 
					ПоддержкаСтрРазделить=Ложь;
			Иначе
				ПоддержкаСтрРазделить=Истина;
			КонецЕсли;
		КонецЕсли;

		Возврат ПоддержкаСтрРазделить;
КонецФункции


&НаКлиенте
Процедура ТаблицаМетаданныхПриАктивизацииСтроки(Элемент)
	ТекущиеДанные = Элементы.ТаблицаМетаданных.ТекущиеДанные;
	Если ТекущиеДанные=Неопределено Тогда
		Возврат;
	КонецЕсли;
	Ключ = ТекущиеДанные.ИмяТаблицыХранения+"->"+ТекущиеДанные.ИмяТаблицы;
	мСтруктура = Новый Структура("Ключ",Ключ);
	Элементы.ТаблицаИндексовМетаданных.ОтборСтрок = Новый ФиксированнаяСтруктура(мСтруктура);
	ТаблицаПолейМетеданных.Очистить();
	ХранилищеРеквизитов = ТекущиеДанные.ХранилищеРеквизитов;
	МассивРеквизитов = ПолучитьМассивРеквизитов(ХранилищеРеквизитов);
	Для каждого стр из МассивРеквизитов Цикл
		ЗаполнитьЗначенияСвойств(ТаблицаПолейМетеданных.Добавить(),стр);
	КонецЦикла;
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьМассивРеквизитов(ХранилищеРеквизитов)
	Возврат ХранилищеРеквизитов.Получить();
КонецФункции

&НаКлиенте
Процедура ТаблицаИндексовМетаданныхПриАктивизацииСтроки(Элемент)
	ТекущиеДанные = Элементы.ТаблицаИндексовМетаданных.ТекущиеДанные;
	Если ТекущиеДанные=Неопределено Тогда
		Возврат;
	КонецЕсли;
	Если ТекущийОтборПолей = "ТаблицаМетаданных" Тогда
		Возврат;
	КонецЕсли;
	ТаблицаПолейМетеданных.Очистить();
	ХранилищеРеквизитов = ТекущиеДанные.ХранилищеРеквизитов;
	МассивРеквизитов = ПолучитьМассивРеквизитов(ХранилищеРеквизитов);
	Для каждого стр из МассивРеквизитов Цикл
		ЗаполнитьЗначенияСвойств(ТаблицаПолейМетеданных.Добавить(),стр);
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ExplainPostgre(Команда)
	
	Explain(Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ExplainPostgreВременный(Команда)
	
	Explain(Ложь);

КонецПроцедуры

&НаКлиенте
Процедура Explain(private=Истина)

	Если ЭтоПланЗапроса=Ложь Тогда		
		Сообщить("Это не план запроса.");
		Возврат;
	КонецЕсли;
	Если НЕ ЗначениеЗаполнено(ТекстЗапроса1С) Тогда
		Сообщить("Не указан текст запроса.");
		Возврат;
	КонецЕсли;
	
	// отправляем на https://explain.tensor.ru/explain
	АдресСервера = "https://explain.tensor.ru";
	АдресСлужбы = АдресСервера+"/explain";
	ДанныеExplain = Новый Структура("plan,query,private",ТекстЗапроса1С,ТекстЗапросаSQL,private);
	СтруктураОтвета = Модуль_СервисныеФункции.ПолучитьДанныеПоИнтернетАдресу(АдресСлужбы,ДанныеExplain,,);
	Если СтруктураОтвета.КодСостояния=302 Тогда
		АдресИнтернетExplain = АдресСервера+СтруктураОтвета.Location;
	Иначе
		АдресИнтернетExplain="";
	КонецЕсли;
КонецПроцедуры 
&НаКлиенте
Процедура АдресИнтернетExplainНажатие(Элемент, СтандартнаяОбработка)
	Если не ЗначениеЗаполнено(АдресИнтернетExplain) Тогда
		Возврат;
	КонецЕсли;
	ЗапуститьПриложение(АдресИнтернетExplain);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьВБраузере(Команда)
	Если не ЗначениеЗаполнено(АдресИнтернетExplain) Тогда
		Возврат;
	КонецЕсли;
	ЗапуститьПриложение(АдресИнтернетExplain);

КонецПроцедуры


#КонецОбласти

&НаКлиенте
Процедура infostart(Команда)
	ЗапуститьПриложение("https://infostart.ru/public/1599708/");
КонецПроцедуры

&НаКлиенте
Процедура tech_log(Команда)
	ЗапуститьПриложение("https://github.com/Polyplastic/1c-parsing-tech-log/");
КонецПроцедуры


&НаКлиенте
Процедура НайтиПоМетаданным(Команда)
	ПоискПоМетаданным();
КонецПроцедуры

&НаКлиенте
Процедура ТипТаблицыПриИзменении(Элемент)
	ПоискПоМетаданным();
КонецПроцедуры

&НаКлиенте
Процедура ГдеИскатьПриИзменении(Элемент)
	ПоискПоМетаданным();
КонецПроцедуры


&НаКлиенте
Процедура СтрокаПоискаПриИзменении(Элемент)
	ПоискПоМетаданным();
КонецПроцедуры


&НаКлиенте
Процедура СтрокаПоискаОчистка(Элемент, СтандартнаяОбработка)
	ПоискПоМетаданным();
КонецПроцедуры


&НаКлиенте
Процедура СтрокаПоискаОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	ПоискПоМетаданным();
КонецПроцедуры


&НаКлиенте
Процедура ПоискПоМетаданным()
	СтрокаПоискаОбработанная = СтрокаПоиска;
	СтрокаПоискаОбработанная = СтрЗаменить(СтрокаПоискаОбработанная," ","");
	мСтруктура = Новый Структура();
	Если ЗначениеЗаполнено(СтрокаПоиска) Тогда
		мСтруктура.Вставить(ГдеИскать,СтрокаПоискаОбработанная);
	КонецЕсли;
	Если НЕ ТипТаблицы="все" Тогда
		мСтруктура.Вставить("ТипТаблицы",ТипТаблицы);
	КонецЕсли;
	Если НЕ ЗначениеЗаполнено(СтрокаПоиска) И ТипТаблицы="все" Тогда
		Элементы.ТаблицаМетаданных.ОтборСтрок = Неопределено;
	Иначе
		Элементы.ТаблицаМетаданных.ОтборСтрок = Новый ФиксированнаяСтруктура(мСтруктура);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнятьТаблицуМетаданныхПриИзменении(Элемент)
	Элементы.Группа5.Видимость=ЗаполнятьТаблицуМетаданных;
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьМетаданные(Команда)
	ПреобразоватьНаСервере(Истина);
КонецПроцедуры


&НаКлиенте
Процедура ПутьКФайлуНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие); 
	Диалог.Заголовок = "Выберите файл"; 
	Если ЗначениеЗаполнено(ПутьКФайлу) Тогда
		Диалог.Каталог = ПолучитьКаталогПоПутиФайла(ПутьКФайлу);
	КонецЕсли;
	Диалог.ПолноеИмяФайла = ""; 
	Фильтр = "TXT-файл (*.txt)|*.txt|SQLPlan-файл (*.SQLPlan)|*.SQLPlan|LOG-файл (*.log)|*.log"; 
	Диалог.Фильтр = Фильтр; 
	Диалог.МножественныйВыбор = Ложь; 
	ВыборФайлаОткрытияФайла = новый ОписаниеОповещения("ВыборФайлаОткрытияФайла",ЭтотОбъект,новый Структура("ИмяРеквизита","ПутьКФайлу"));
	Диалог.Показать(ВыборФайлаОткрытияФайла);
КонецПроцедуры

&НаКлиенте
Функция  ПолучитьКаталогПоПутиФайла(Знач ПутьКФайлу)
	Файл = новый Файл(ПутьКФайлу);
	Возврат Файл.Путь;	
КонецФункции

&НаКлиенте
Процедура ВыборФайлаОткрытияФайла(ВыбранныеФайлы, ДополнительныеПараметры) Экспорт
	
	Если ВыбранныеФайлы <> Неопределено И ВыбранныеФайлы.Количество() > 0 Тогда
		ЭтаФорма[ДополнительныеПараметры.ИмяРеквизита] = ВыбранныеФайлы[0]; 
	КонецЕсли; 
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФайл(Команда)
	Документ = новый ТекстовыйДокумент;
	//ПараметрыЧтения = Новый Структура("Документ",Документ);//2
	//ОткрытьФайлаПроектаДиалог = новый ОписаниеОповещения("ОткрытьФайлаПроектаДиалог",ЭтотОбъект,ПараметрыЧтения);	
	//Документ.НачатьЧтение("ОткрытьФайлаПроектаДиалог",ПутьКФайлу,"UTF-8");
	Документ.Прочитать(ПутьКФайлу,КодировкаТекста.UTF8);
	ТекстЗапросаSQL = " "+ОбработатьВходнойФайл(Документ.ПолучитьТекст());
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФайлаПроектаДиалог(ДополнительныеПараметры) Экспорт
	
	ТекстЗапросаSQL = ОбработатьВходнойФайл(Параметры.Документ.ПолучитьТекст());
	
КонецПроцедуры 
&НаКлиенте
Функция ОбработатьВходнойФайл(Знач ТекстВходной)
	
	Если Найти(ТекстВходной,"><") И Найти(ТекстВходной,"schemas.microsoft.com") Тогда
		ТекстВходной = СтрЗаменить(ТекстВходной,"><",">"+Символы.ПС+"<");
	КонецЕсли;
	
	Возврат ТекстВходной; 

КонецФункции


&НаКлиенте
Процедура СохранитьФайл(Команда)
	
	Если ТекстЗапроса1С="" Тогда
		Возврат;
	КонецЕсли;
	
	Документ = новый ТекстовыйДокумент;
	Документ.УстановитьТекст(ТекстЗапроса1С);
	СохранениеФайлаПроектаДиалог = новый ОписаниеОповещения("СохранениеФайлаПроектаДиалог",ЭтотОбъект);
	ПутьКФайлуКопии = ПутьКФайлу;
	Если НЕ Найти(ПутьКФайлу,"1C") Тогда		
		Файл = Новый Файл(ПутьКФайлуКопии);
		ПутьКФайлуКопии = Файл.Путь+""+Файл.ИмяБезРасширения+"-1C"+Файл.Расширение;
	КонецЕсли;
	Документ.НачатьЗапись(СохранениеФайлаПроектаДиалог,ПутьКФайлуКопии,"UTF-8");

КонецПроцедуры

&НаКлиенте
Процедура СохранениеФайлаПроектаДиалог(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат=Истина Тогда		
	Иначе
		Сообщить("При сохранении файла произошла ошибка!");	
	КонецЕсли;
	
КонецПроцедуры


&НаКлиенте
Процедура ТекущийОтборПолейПриИзменении(Элемент)   
	Если ТекущийОтборПолей="ТаблицаИндексовМетаданных" Тогда
		ТаблицаИндексовМетаданныхПриАктивизацииСтроки(Неопределено);
	Иначе
		ТаблицаМетаданныхПриАктивизацииСтроки(Неопределено);
	КонецЕсли;
КонецПроцедуры

