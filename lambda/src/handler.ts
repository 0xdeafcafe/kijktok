import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';

const domain = 'https://www.tikwm.com';
const headers = new Headers({
	'Accept': 'application/json, text/javascript, */*; q=0.01',
	'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
	'Sec-CH-UA': '"Chromium";v="104", " Not A;Brand";v="99", "Google Chrome";v="104"',
	'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/104.0.0.0 Safari/537.36'
});

export const handler = async (event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult> => {
	if (event.queryStringParameters === null) {
		return error('no_query_provided', 400);
	}

	const url = event.queryStringParameters.url;

	if (!url) {
		return error('no_url_provided', 400);
	}

	const response = await fetch(`${domain}/api/`, {
		method: 'POST',
		headers,
		body: JSON.stringify({
			url: url.trim(),
			count: '12',
			cursor: '0',
			web: '1',
			hd: '1',
		}),
	});

	const responseJson = await response.json();
	const videoPathname = responseJson.data.play;
	const videoUrl = `${domain}${videoPathname}`;

	return respond({ videoUrl });
}

function respond(body: any) {
	return {
		statusCode: 200,
		body: JSON.stringify(body),
	};
}

function error(code: string, statusCode: number) {
	return {
		statusCode,
		body: JSON.stringify({ code }),
	};
}
