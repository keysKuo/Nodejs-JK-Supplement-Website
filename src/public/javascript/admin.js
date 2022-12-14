$(document).ready(function () {
    $('#addRow').click(function () {
        let html = ``;
        html += `<div id="inputFormRow" class="row">
        <div class="col-sm-3">
        <div class="form-group mb-4">
            <input type="number" placeholder="Nhập số lượng" name="quantity[]"
                class="form-control" required="">
                </div>
        </div>
        <div  class="col-sm-3">
            <div class="form-group">
                <div class="input-group">
                    <input type="number" placeholder="Nhập giá" value="0"  name="price[]"
                        class="form-control" required="">
                </div>
            </div>
        </div>
        <div class="col-sm-3">
            <div class="form-group">
                <input type="number" name="discount[]" value="0" placeholder="Nhập khuyến mãi (%)" required=""
                class="form-control">
            </div>
        </div>
        <div class="col-sm-3">
            <div class="form-group">
                <div class="input-group">
                    <input type="text" placeholder="Nhập kích thước" name="size[]"
                        class="form-control" required="">
                    <button id="removeRow" type="button"
                        class="btn btn-danger">Xóa</button>
                </div>
            </div>
        </div>
    </div>`
        $('#newRow').append(html)
    })
    $(document).on('click', '#removeRow', function () {
        $(this).closest('#inputFormRow').remove();
    });
})