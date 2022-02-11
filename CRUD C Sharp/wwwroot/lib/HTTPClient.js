let HTTPClient = {
    get: (url) => {
        let config = {
            method: 'get',
            headers: {
                'Accept': "application/json",
                "Content-Type": "application/json; charset=utf-8"
            }
        }
        return fetch(url, config);
    },

    post: (url, dados) => {

        let config = {
            method: 'post',
            body: JSON.stringify(dados),
            headers: {
                'Accept': "application/json",
                "Content-Type": "application/json; charset=utf-8"
            }
        }
        return fetch(url, config);
    },

    put: (url, dados) => {

        let config = {
            method: 'put',
            body: JSON.stringify(dados),
            headers: {
                'Accept': "application/json",
                "Content-Type": "application/json; charset=utf-8"
            }
        }
        return fetch(url, config);
    },

    delete: (url) => {

        let config = {
            method: 'delete',
            headers: {
                'Accept': "application/json",
                "Content-Type": "application/json; charset=utf-8"
            }
        }
        return fetch(url, config);
    }
}